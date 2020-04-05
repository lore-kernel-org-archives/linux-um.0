Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKxEy-000825-AR
 for linux-um@lists.infradead.org; Sun, 05 Apr 2020 04:50:37 +0000
Received: by mail-pl1-x62d.google.com with SMTP id s23so4522985plq.13
 for <linux-um@lists.infradead.org>; Sat, 04 Apr 2020 21:50:35 -0700 (PDT)
Received: from localhost (tk2-262-40541.vs.sakura.ne.jp. [160.16.240.45])
 by smtp.gmail.com with ESMTPSA id gi2sm9023491pjb.30.2020.04.04.21.50.33
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2020 21:50:34 -0700 (PDT)
Date: Sun, 5 Apr 2020 12:50:31 +0800
From: Lingyu Zhu <lynuszhu@gmail.com>
Subject: Clean up scripts/tags.sh
Message-ID: <20200405045030.sslbedviyt7zqwhi@lynus-laptop>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

Hello. Yesterday I asked on #kernelnewbies IRC channel whether um supports arch
other than x86, and I got the answer that um right now only works on x86.
I consider scripts/tags.sh needs a little cleaning up. First, this script fails
to collect files under arch/x86/um to produce tags. Second, it collect the
extra files from the arch/$SUBARCH, which I considered pointless. Since
um only works on x86, it's better to collect arch/x86/um for x86 um build,
and output error message for other cases.
Also, I wonder is it proper to send the scripts/tags.sh patch to this list?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

