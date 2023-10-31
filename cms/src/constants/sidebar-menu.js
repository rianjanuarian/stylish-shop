import DashboardIcon from '../assets/icons/apps.svg';
import ShippingIcon from '../assets/icons/crown.svg';
import ProductIcon from '../assets/icons/truck-side.svg';
import UserIcon from '../assets/icons/user.svg';
import Users from '../assets/icons/users.svg'
const sidebar_menu = [
    {
        id: 1,
        icon: DashboardIcon,
        path: '/dashboard',
        title: 'Dashboard',
    },
    {
        id: 2,
        icon: ProductIcon,
        path: '/orders',
        title: 'Orders',
    },
    {
        id: 3,
        icon: ShippingIcon,
        path: '/products',
        title: 'Products',
    },
    {
        id: 4,
        icon: Users,
        path: '/user',
        title: 'User',
    },
    {
        id: 5,
        icon: UserIcon,
        path: '/profile',
        title: 'My account',
    },
  
]

export default sidebar_menu;