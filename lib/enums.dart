enum MenuState { home, menu, order, favorite, profile }
enum SIZE { s, m, l }
List orderStatus = [
  {
    "id": 0,
    "name": 'Chờ xử lý',
    "status": 'InProgress',
  },
  {
    "id": 1,
    "name": 'Đang giao',
    "status": 'Delivering',
  },
  {
    "id": 2,
    "name": 'Thành công',
    "status": 'Success',
  },
  {
    "id": 3,
    "name": 'Đã hủy',
    "status": 'Canceled',
  },
  {
    "id": 4,
    "name": 'Tất cả',
    "status": 'All',
  },
];
