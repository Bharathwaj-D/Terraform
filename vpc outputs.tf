output "vpc_id"{
    value = aws_vpc.VPC.id 
}

output "Publicsubnet1" {
  value = aws_subnet.PublicSubnetA.id 
}
output "Publicsubnet2" {
  value = aws_subnet.PublicSubnetB.id 
}
output "Publicsubnet3" {
  value = aws_subnet.PublicSubnetC.id 
}
output "Privatesubnet1" {
  value = aws_subnet.PrivateSubnetA.id 
}
output "Privatesubnet2" {
  value = aws_subnet.PrivateSubnetB.id 
}
output "Privatesubnet3" {
  value = aws_subnet.PrivateSubnetC.id 
}
