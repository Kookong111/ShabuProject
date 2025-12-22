<%-- Navbar Include: ใช้ซ้ำได้ทุกหน้า --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
    nav {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        padding: 24px 5%;
        min-height: 64px;
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border-bottom: 1px solid var(--border);
        z-index: 1000;
        transition: transform 0.3s ease;
    }
    .nav-container {
        display: flex;
        align-items: center;
        justify-content: center;
        max-width: 1400px;
        margin: 0 auto;
        flex-wrap: nowrap;
        gap: 0;
    }
    .logo {
        font-size: 28px;
        font-weight: 600;
        color: var(--text-primary);
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .nav-menu {
        display: flex;
        list-style: none;
        gap: 18px;
        align-items: center;
        white-space: nowrap;
        font-size: 14px;
        margin: 0 auto;
        padding: 0;
    }
    .nav-menu a {
        color: var(--text-primary, #1a1a1a);
        text-decoration: none;
        font-weight: 500;
        font-size: 1.15em;
        padding: 10px 0;
        position: relative;
        transition: all 0.3s ease;
    }
    .nav-menu a::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 0;
        height: 2px;
        background: var(--text-primary, #1a1a1a);
        transition: width 0.3s ease;
    }
    .nav-menu a:hover::after,
    .nav-menu a.active::after {
        width: 100%;
    }
    .nav-menu a:hover {
        color: inherit;
    }
    .user-actions {
        display: flex;
        align-items: center;
        gap: 16px;
        flex-wrap: nowrap;
    }
    .logout-btn {
        padding: 8px 20px;
        background: rgba(0, 0, 0, 0.05);
        border: 1px solid var(--border);
        border-radius: 24px;
        color: var(--text-primary);
        text-decoration: none;
        font-size: 14px;
        font-weight: 400;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
        position: relative;
    }
    .logout-btn .fa-sign-out-alt, .logout-btn .fa-sign-in-alt {
        background: #fff;
        border-radius: 50%;
        box-shadow: 0 2px 8px rgba(0,0,0,0.10);
        color: #1a1a1a;
        width: 32px;
        height: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        margin-right: 4px;
    }
    .logout-btn:hover {
        background: rgba(0, 0, 0, 0.08);
        border-color: rgba(0, 0, 0, 0.15);
    }
    @media (max-width: 900px) {
        .nav-container {
            flex-direction: row;
            align-items: center;
            justify-content: center;
            flex-wrap: nowrap;
            gap: 0;
        }
        .user-actions {
            flex-wrap: nowrap !important;
        }
    }
    @media (max-width: 768px) {
        nav {
            padding: 24px 3%;
            min-height: 64px;
        }
        .nav-container {
            flex-direction: row;
            align-items: center;
            justify-content: center;
            flex-wrap: nowrap;
            gap: 0;
        }
        .logo {
            font-size: 22px;
        }
        .user-actions {
            flex-direction: row;
            gap: 8px;
            justify-content: flex-end;
            align-items: center;
            width: auto;
            flex-wrap: nowrap;
        }
        .logout-btn {
            min-width: 0;
            white-space: nowrap;
            padding: 4px 8px;
            font-size: 13px;
        }
        .nav-menu {
            gap: 10px;
            font-size: 13px;
        }
    }
    @media (max-width: 480px) {
        nav {
            padding: 8px 2%;
        }
        .logo {
            font-size: 16px;
        }
        .nav-container {
            flex-direction: row;
            align-items: center;
            justify-content: center;
            flex-wrap: nowrap;
            gap: 0;
        }
        .user-actions {
            flex-direction: row;
            gap: 4px;
            justify-content: flex-end;
            align-items: center;
            width: auto;
            flex-wrap: nowrap;
        }
        .logout-btn {
            min-width: 0;
            white-space: nowrap;
            font-size: 12px;
            padding: 4px 6px;
        }
    }
</style>
<div class="navbar-center">
    <a href="#" class="logo" style="margin-right: 18px;">
        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo3CoNAKF4SAN6UY7VZzw8XkIwYTatFOoBow&s" alt="ShaBu Logo" style="height:50px; width: auto; display:block;" />
    </a>
    <ul class="nav-menu">
        <li><a href="gotowelcomeCustomerCheck" class="${fn:contains(pageContext.request.servletPath, 'welcome') ? 'active' : ''}">หน้าแรก</a></li>
        <li><a href="menurecomand" class="${fn:contains(pageContext.request.servletPath, 'menu') ? 'active' : ''}">เมนู</a></li>
        <li><a href="listTable" class="${fn:contains(pageContext.request.servletPath, 'listTable') ? 'active' : ''}">จองโต๊ะ</a></li>
        <li><a href="gotoContact" class="${fn:contains(fn:toLowerCase(pageContext.request.servletPath), 'contact') ? 'active' : ''}">ติดต่อเรา</a></li>
    </ul>
    <div class="user-actions">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <a href="logoutCustomer" class="logout-btn">
                    <span>${sessionScope.user.cusname}</span>
                    <i class="fas fa-sign-out-alt" style="color: red;"></i>
                </a>
            </c:when>
            <c:otherwise>
                <a href="gotologin" class="logout-btn"><i class="fas fa-sign-in-alt" style="color: green;"></i> เข้าสู่ระบบ</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</style>
<style>
    .navbar-center {
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 24px;
        flex-wrap: nowrap;
    }
    .navbar-center .user-info {
        white-space: nowrap;
    }
    .navbar-center .nav-menu {
        flex: 1 1 auto;
        justify-content: center;
        margin: 0 8px;
    }
    .navbar-center a[title="ออกจากระบบ"] {
        min-width: 32px;
        justify-content: center;
    }
    @media (max-width: 768px) {
        .navbar-center {
            gap: 8px;
        }
        .navbar-center .nav-menu {
            gap: 10px;
            font-size: 13px;
        }
    }
</style>
