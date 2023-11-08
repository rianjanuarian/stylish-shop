import React, { useState, useEffect } from 'react';
import DashboardHeader from '../../components/DashboardHeader';
import sidebar_menu from '../../constants/sidebar-menu';
import SideBar from '../../components/Sidebar/Sidebar';
import '../styles.css';
import DoneIcon from '../../assets/icons/done.svg';
import CancelIcon from '../../assets/icons/cancel.svg';
import RefundedIcon from '../../assets/icons/refunded.svg';
import { getTransactions, transactionSelectors } from '../../redux/transactionSlice';
import { useSelector, useDispatch } from "react-redux";
import Loading from '../../helpers/Loading/Loading';


function Orders() {
    const dispatch = useDispatch()
    const transactions = useSelector(transactionSelectors.selectAll)
    const status = useSelector((state) => state.transactions.status);
    const error = useSelector((state) => state.transactions.error);
    useEffect(() => {
        dispatch(getTransactions())
    }, [dispatch])
    return (
        <div className='dashboard-container'>
            <SideBar menu={sidebar_menu} />
            <div className='dashboard-body'>
                <div className='dashboard-content'>
                    <DashboardHeader
                        btnText="New Order" />

                    <div className='dashboard-content-container'>
                        <div className='dashboard-content-header'>
                            <h2>Orders List</h2>

                        </div>

                        <table>
                            <thead>
                                <th>No</th>
                                <th>USER</th>
                                <th>CART ID</th>
                                <th>COURIER</th>
                                <th>ORDER ID</th>
                                <th>MIDTRANS</th>
                                <th>STATUS</th>
                            </thead>

                            {status === "loading" ?
                                <div className="loading-animate">
                                    <Loading></Loading></div>
                                : status === "rejected" ? <p>{error}</p> :
                                    transactions.length !== 0 ?
                                        <tbody>
                                            {transactions.map((e, index) => (
                                                <tr key={e.id}>
                                                    <td><span>{index + 1}</span></td>
                                                    <td><span>{e.user.name}</span></td>
                                                    <td><span>{e.cartId}</span></td>
                                                    <td><span>{e.courier.name}</span></td>
                                                    <td><span>{e.orderId}</span></td>
                                                    <td><span>{e.midtranstoken}</span></td>
                                                    <td><div>{e.status === 'pending' ? <img
                                                        src={RefundedIcon}
                                                        alt='refunded-icon'
                                                        className='dashboard-content-icon' />
                                                        : e.status === 'approve' ?
                                                            <img
                                                                src={DoneIcon}
                                                                alt='refunded-icon'
                                                                className='dashboard-content-icon' />
                                                            : e.status === 'reject' ?
                                                                <img
                                                                    src={CancelIcon}
                                                                    alt='refunded-icon'
                                                                    className='dashboard-content-icon' />
                                                                : null}
                                                        <span>{e.status}</span>
                                                    </div></td>

                                                </tr>
                                            ))}
                                        </tbody>
                                        : null}
                        </table>





                    </div>
                </div>
            </div>
        </div>
    )
}

export default Orders;