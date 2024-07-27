resource "outscale_net" "main_vpc" {
  ip_range = var.vpc_ip_range
  tenancy  = "default"

  tags {
    key   = "Name"
    value = "terraform-vpc"
  }
}

resource "outscale_subnet" "subnet_public" {
  net_id         = outscale_net.main_vpc.id
  ip_range       = var.subnet_ip_range_public
  subregion_name = "${var.region}a"
}

resource "outscale_internet_service" "internet_service" {
  tags {
    key   = "Name"
    value = "terraform-internet-gateway"
  }
}

resource "outscale_internet_service_link" "internet_service_link" {
  net_id              = outscale_net.main_vpc.id
  internet_service_id = outscale_internet_service.internet_service.internet_service_id
}

resource "outscale_route_table" "route_table_public" {
  net_id     = outscale_net.main_vpc.id
  depends_on = [outscale_subnet.subnet_public]

  tags {
    key   = "Name"
    value = "terraform-route-table-public"
  }
}

resource "outscale_route_table_link" "route_table_link_public" {
  subnet_id      = outscale_subnet.subnet_public.id
  route_table_id = outscale_route_table.route_table_public.id
}

resource "outscale_route" "p_subnet_igw_route" {
  route_table_id       = outscale_route_table.route_table_public.id
  destination_ip_range = "0.0.0.0/0"
  gateway_id           = outscale_internet_service.internet_service.id
  depends_on           = [outscale_internet_service.internet_service]
}
