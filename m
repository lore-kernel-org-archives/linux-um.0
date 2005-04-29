Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRTq2-0003PI-FB	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Apr 2005 04:39:18 -0700
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DRTpz-0001pf-DT	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Apr 2005 04:39:18 -0700
Message-ID: <56284.80.203.9.198.1114774752.squirrel@80.203.9.198>
In-Reply-To: <001f01c54c9f$7d9dc5d0$90b3c68a@SHZ.ST.COM>
References: <200504292220.48040.blaisorblade@yahoo.it>
    <001f01c54c9f$7d9dc5d0$90b3c68a@SHZ.ST.COM>
Subject: RE: [uml-devel] Question about kernel_thread in UML TT mode
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 29 Apr 2005 13:39:12 +0200 (CEST)
To: Alex LIU <alex.liu@st.com>
Cc: 'Blaisorblade' <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

> extern void kernel_thread_helper(void);
> __asm__(".section .text\n"
> 	".align 4\n"
> 	"kernel_thread_helper:\n\t"
> 	"movl %edx,%eax\n\t"
> 	"pushl %edx\n\t"
> 	"call *%ebx\n\t"
> 	"pushl %eax\n\t"
> 	"call do_exit\n"
> 	".previous");

kernel_thread helper is just a dummy wrapper to feed into kernel_thread
and can probably look at as a static local function only for use of x86
implementation of kernel_thread.


Stian


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
