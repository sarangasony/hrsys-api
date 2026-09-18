import { Injectable } from '@nestjs/common';

@Injectable()
export class AuthService {
  getStatus() {
    return { status: 'stub', loginEnabled: false };
  }
}
