resource "aws_key_pair" "general_key" {
  key_name   = "general"
  public_key = file("./key_pairs/general.pub")
}
