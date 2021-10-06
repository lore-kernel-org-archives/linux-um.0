Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYCmg-00FQ1U-9n
 for linux-um@lists.infradead.org; Wed, 06 Oct 2021 19:40:59 +0000
Received: by mail-qk1-x72e.google.com with SMTP id l7so3803730qkk.0
 for <linux-um@lists.infradead.org>; Wed, 06 Oct 2021 12:40:56 -0700 (PDT)
Received: from crass-HP-ZBook-15-G2 ([37.218.244.251])
 by smtp.gmail.com with ESMTPSA id f83sm12141055qke.79.2021.10.06.12.40.54
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Oct 2021 12:40:55 -0700 (PDT)
Date: Wed, 6 Oct 2021 14:40:48 -0500
From: Glenn Washburn <development@efficientek.com>
Subject: Is exec still very slow compared to other aspects of UML?
Message-ID: <20211006144048.6a42a958@crass-HP-ZBook-15-G2>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: development@efficientek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

Hi all,

After reading this blog post[1], which I think is at least several years
old, I'm left wondering how much of an issue is the exec speed. Or
alternatively, could I see a significant speed up by reducing the
number of exec calls. Any one have opinions on this?

Glenn

[1] https://www.kot-begemot.co.uk/node/15

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

