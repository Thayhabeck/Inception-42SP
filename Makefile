include ./srcs/.env
export

GR	= \033[32;1m
RE	= \033[31;1m
CY	= \033[36;1m
RC	= \033[0m

all: confs up

confs:
	@ printf "\r$(CY)Configuring Inception...$(RC)\n"
	@ sudo mkdir -p /home/thabeck-/data/mariadb
	@ sudo mkdir -p /home/thabeck-/data/wordpress
	@ sudo grep "${DOMAIN_NAME}" /etc/hosts || sudo sh -c 'echo "127.0.0.1 ${DOMAIN_NAME}" >> /etc/hosts'

up:
	@ printf "\r$(CY)Building Inception...$(RC)\n"
	@ docker-compose -f srcs/docker-compose.yml up --build -d
	@ printf "$(GR)Inception is Up!$(RC)\n"

clean:
	@ printf "\r$(RE)Removing Inception...$(RC)\n"
	@ docker-compose -f srcs/docker-compose.yml down --rmi all
	@ printf "\r$(RE)Inception is down!$(RC)\n"

fclean: clean
	@ printf "\r$(RE)Removing Inception persistent volumes...$(RC)\n"
	@ docker volume rm wordpress mariadb
	@ printf "\r$(RE)Removing Inception cache...$(RC)\n"
	@ docker system prune --force
	@ printf "\r$(RE)Removing Inception data folder...$(RC)\n"
	@ sudo rm -rf /home/thabeck-/data
	@ printf "\r$(RE)Removing Inception host...$(RC)\n"
	@ sudo sed -i "/127.0.0.1 ${DOMAIN_NAME}/d" /etc/hosts
	@ printf "\r$(RE)Inception environment has been cleaned!$(RC)\n"


re: fclean all

terminaldb:
	docker exec -it mariadb /bin/ash 2>/dev/null || true

terminalwp:
	docker exec -it wordpress /bin/ash 2>/dev/null || true

terminalngx:
	docker exec -it nginx /bin/ash 2>/dev/null || true

.PHONY: all clean fclean re confs terminaldb terminalwp terminalngx
