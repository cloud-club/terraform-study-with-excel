resource "aws_instance" "jjaegii" {
  ami           = "ami-012e764b9ddef07c2" # RHEL 9 AMI ID
  instance_type = "t2.micro"              # EC2 인스턴스 타입 (프리 티어 가능)

  # 인스턴스 시작 시 실행할 스크립트 (User Data)
  user_data = <<-EOF
              #!/bin/bash
              # Apache 설치
              sudo dnf install -y httpd

              # Apache 서버 시작 및 부팅 시 자동 시작 설정
              sudo systemctl start httpd
              sudo systemctl enable httpd

              # Hello, World! 메시지를 웹 루트에 출력
              echo "Hello, World!" > /var/www/html/index.html

              # 방화벽에서 HTTP 트래픽 허용 (RHEL에 따라 필요할 수 있음)
              sudo firewall-cmd --permanent --add-service=http
              sudo firewall-cmd --reload
              EOF

  vpc_security_group_ids = [aws_security_group.allow_http.id]

  tags = {
    Name = "HelloWorldEC2"
  }
}