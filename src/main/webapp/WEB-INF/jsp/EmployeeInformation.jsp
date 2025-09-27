<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8" />
  <title>จัดการพนักงาน</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

  <style>
    :root{
      --bg-1:#f5f3ff;
      --bg-2:#e9e1ff;
      --brand-700:#5b2e8c;
      --brand-800:#472273;
      --brand-900:#34195a;
      --brand-300:#d9c7ff;
      --ink-900:#101828;
      --ink-600:#475467;
      --ink-500:#667085;
      --card:#ffffff;
      --ring:#bda3ff;
    }

    *{margin:0;padding:0;box-sizing:border-box}
    html,body{height:100%}
    body{
      font-family:'Inter',sans-serif;
      min-height:100vh;
      color:var(--ink-900);
      background:
        radial-gradient(1200px 600px at 20% -10%, #efe9ff 0%, transparent 60%),
        radial-gradient(900px 500px at 110% 0%, #f1eaff 0%, transparent 55%),
        linear-gradient(135deg, var(--bg-1) 0%, var(--bg-2) 100%);
      overflow-x:hidden;
    }

    /* Header */
    .header-section{
      position:relative;
      background:linear-gradient(135deg,var(--brand-700) 0%, var(--brand-900) 100%);
      color:#fff;
      padding:72px 0 96px;   /* ขยายให้โปร่ง */
      overflow:hidden;
      border-bottom:1px solid rgba(255,255,255,.15);
    }
    .header-content{
      position:relative;z-index:1;max-width:1200px;margin:0 auto;padding:0 24px;text-align:center
    }
    .page-title{
      font-size:2.4rem;font-weight:700;margin:6px 0;
      text-shadow:0 6px 30px rgba(0,0,0,.22);
    }
    .page-subtitle{opacity:.85;font-weight:300}

    .back-button{
      position:absolute;top:20px;left:20px;
      background:rgba(255,255,255,.12);
      border:1px solid rgba(255,255,255,.28);
      color:#fff;padding:10px 14px;border-radius:999px;
      display:flex;align-items:center;gap:8px;font-weight:500;
      transition:.25s ease;backdrop-filter:blur(10px);
      box-shadow:0 6px 24px rgba(0,0,0,.15);
      text-decoration:none !important;
    }
    .back-button:hover{transform:translateY(-2px);background:rgba(255,255,255,.18);color:#fff;text-decoration:none}

    /* Main */
    .main-content{margin-top:0;padding:24px 0 80px;}
    .content-container{max-width:1100px;margin:0 auto;padding:0 32px}

    .section-title{
      font-size:1.25rem;font-weight:700;
      color:var(--brand-800);
      text-align:center;margin:0 0 26px;
    }

    /* Cards grid */
    .actions-grid{
      display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));
      gap:28px;
    }

    /* Card */
    .action-section{
      background:var(--card);
      border-radius:18px;
      padding:28px 26px;
      border:1px solid var(--brand-300);
      box-shadow:0 12px 30px rgba(68,32,116,.08);
      transition:.22s ease;
    }
    .action-section:hover{
      transform:translateY(-4px);
      box-shadow:0 16px 40px rgba(68,32,116,.14);
      border-color:#c9b6ff;
    }

    .section-header{text-align:center;margin-bottom:18px}
    .section-icon{
      width:64px;height:64px;margin:0 auto 14px;border-radius:16px;
      display:grid;place-items:center;
      background:linear-gradient(135deg,#efe7ff 0%, #e5dcff 100%);
      border:1px solid #e5dcff;
      box-shadow:inset 0 1px 0 #fff, 0 8px 20px rgba(79,38,135,.12)
    }
    .section-icon i{font-size:26px;color:var(--brand-800)}

    .section-title-text{font-size:1.15rem;font-weight:700;color:var(--ink-900);letter-spacing:.2px}

    /* Buttons */
    .action-buttons{display:flex;flex-direction:column;gap:12px;margin-top:8px}
    .action-btn{
      border:none;border-radius:12px;
      padding:14px 18px;font-weight:600;font-size:.96rem;
      display:flex;align-items:center;justify-content:center;gap:10px;
      color:#fff;background:linear-gradient(135deg,var(--brand-700),var(--brand-900));
      box-shadow:0 10px 24px rgba(70,36,119,.35);
      transition:.2s ease;
      text-decoration:none !important;
    }
    .action-btn:hover{transform:translateY(-2px);box-shadow:0 14px 34px rgba(70,36,119,.45);color:#fff;text-decoration:none}
    .action-btn.secondary{
      background:#fff;color:var(--brand-900);
      border:1px solid #ded2ff;box-shadow:0 8px 18px rgba(90,54,150,.08);
      text-decoration:none !important;
    }
    .action-btn.secondary:hover{border-color:#c7b4ff;box-shadow:0 12px 28px rgba(90,54,150,.14)}

    /* Responsive */
    @media (max-width:768px){
      .page-title{font-size:1.9rem}
      .header-section{padding:60px 0 80px}
      .content-container{padding:0 20px}
      .actions-grid{grid-template-columns:1fr}
    }
  </style>
</head>
<body>
  <!-- Header -->
  <div class="header-section">
    <div class="header-content">
      <h1 class="page-title">จัดการพนักงาน</h1>
      
    </div>
    <a href="home" class="back-button"><i class="fas fa-arrow-left"></i> กลับสู่หน้าหลัก</a>
  </div>

  <!-- Main -->
  <div class="main-content">
    <div class="content-container">
      

      <div class="actions-grid">
        <!-- Waiter -->
        <div class="action-section">
          <div class="section-header">
            <div class="section-icon"><i class="fas fa-utensils"></i></div>
            <h3 class="section-title-text">พนักงานเสิร์ฟ</h3>
          </div>
          <div class="action-buttons">
            <a href="gotoAddwaiter" class="action-btn">
              <i class="fas fa-plus"></i> เพิ่มพนักงานเสิร์ฟ
            </a>
            <a href="listwaiter" class="action-btn secondary">
              <i class="fas fa-list"></i> ดูข้อมูลพนักงานเสิร์ฟ
            </a>
          </div>
        </div>

        <!-- Cashier -->
        <div class="action-section">
          <div class="section-header">
            <div class="section-icon"><i class="fas fa-cash-register"></i></div>
            <h3 class="section-title-text">พนักงานแคชเชียร์</h3>
          </div>
          <div class="action-buttons">
            <a href="gotoAddcashier" class="action-btn">
              <i class="fas fa-plus"></i> เพิ่มพนักงานแคชเชียร์
            </a>
            <a href="listcashier" class="action-btn secondary">
              <i class="fas fa-list"></i> ดูข้อมูลพนักงานแคชเชียร์
            </a>
          </div>
        </div>
      </div>

    </div>
  </div>
</body>
</html>
