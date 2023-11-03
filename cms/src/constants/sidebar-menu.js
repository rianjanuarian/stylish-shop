import { RxDashboard } from "react-icons/rx";
import { LiaShippingFastSolid } from "react-icons/lia";
import { PiCrownBold } from "react-icons/pi";
import { RiFileListLine } from "react-icons/ri";
import { BsShop } from "react-icons/bs";
import { FiUsers } from "react-icons/fi";
import { AiOutlineUser } from "react-icons/ai";

const sidebar_menu = [
  {
    id: 1,
    icon: RxDashboard,
    path: "/dashboard",
    title: "Dashboard",
  },
  {
    id: 2,
    icon: LiaShippingFastSolid,
    path: "/orders",
    title: "Orders",
  },
  {
    id: 4,
    icon: PiCrownBold,
    path: "/brands",
    title: "Brands",
  },
  {
    id: 5,
    icon: RiFileListLine,
    path: "/categories",
    title: "Categories",
  },
  {
    id: 6,
    icon: BsShop,
    path: "/products",
    title: "Products",
  },
  {
    id: 7,
    icon: FiUsers,
    path: "/user",
    title: "User",
  },
  {
    id: 8,
    icon: AiOutlineUser,
    path: "/profile",
    title: "My account",
  },
];

export default sidebar_menu;
