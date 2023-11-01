import DashboardIcon from '../assets/icons/apps.svg';
import ShippingIcon from '../assets/icons/crown.svg';
import ProductIcon from '../assets/icons/truck-side.svg';
import UserIcon from '../assets/icons/user.svg';
import Users from '../assets/icons/users.svg'
import Products from '../assets/icons/shop.svg'
import Category from '../assets/icons/document-signed.svg'
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
        id: 4,
        icon: ShippingIcon,
        path: '/brands',
        title: 'Brands',
    },
    {
        id: 5,
        icon: Category,
        path: '/categories',
        title: 'Categories',
    },
    {
        id: 6,
        icon: Products,
        path: '/products',
        title: 'Products',
    },
    {
        id: 7,
        icon: Users,
        path: '/user',
        title: 'User',
    },
    {
        id: 8,
        icon: UserIcon,
        path: '/profile',
        title: 'My account',
    },
  
]

export default sidebar_menu;