resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = aws_vpc.VPCA.id
  peer_vpc_id   = aws_vpc.VPCB.id
  auto_accept   = true

  tags = {
    Name = "peer-VPCA-VPCB"
  }
}

resource "aws_route" "route_peer_A_to_B" {
  route_table_id         = aws_route_table.route_table_A.id
  destination_cidr_block = aws_vpc.VPCB.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route" "route_peer_B_to_A" {
  route_table_id         = aws_route_table.route_table_B.id
  destination_cidr_block = aws_vpc.VPCA.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
