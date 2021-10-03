Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mWqns-0032Pt-MZ
 for linux-um@lists.infradead.org; Sun, 03 Oct 2021 02:00:38 +0000
Received: by mail-qk1-x72e.google.com with SMTP id d207so2477259qkg.0
 for <linux-um@lists.infradead.org>; Sat, 02 Oct 2021 19:00:30 -0700 (PDT)
Received: from crass-HP-ZBook-15-G2 ([37.218.244.251])
 by smtp.gmail.com with ESMTPSA id 139sm5349968qkd.130.2021.10.02.19.00.28
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Oct 2021 19:00:29 -0700 (PDT)
Date: Sat, 2 Oct 2021 21:00:23 -0500
From: Glenn Washburn <development@efficientek.com>
Subject: Bug 214611 - UM: stdout output ceases under certain conditions
Message-ID: <20211002210023.55861502@crass-HP-ZBook-15-G2>
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

Hi list,

I'm notifying the list of a bug report[1] I created in the kernel
bugzilla. I'm not subscribed to this list, so please add this my email
in any replies to this email.

Separately, I noticed that the bugzilla told me that an email was being
sent to inout@users.sourceforge.net and jdike@karaya.com. My
understanding is that the Source Forge list is in active and that Jeff
Dike seems to not be an active maintainer. Regardless, I believe this
list should be on the list of recipients for created bug reports for
the UM architecture. Perhaps a maintainer can contact the buzilla team.

Glenn

[1] https://bugzilla.kernel.org/show_bug.cgi?id=214611

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

