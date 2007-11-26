Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwacQ-00084u-4s for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 01:51:10 -0800
Received: from ug-out-1314.google.com ([66.249.92.173])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwacO-0006oj-H7
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 01:51:10 -0800
Received: by ug-out-1314.google.com with SMTP id m2so924694uge
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 26 Nov 2007 01:51:06 -0800 (PST)
Message-ID: <474A9701.4040908@gmail.com>
Date: Mon, 26 Nov 2007 10:50:57 +0100
From: Jiri Olsa <olsajiri@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] PROC_MM
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Hi,

I see some code related to PROC_MM 


static inline void check_skas3_proc_mm(void)
{
        non_fatal("  - /proc/mm...");
        if (access("/proc/mm", W_OK) < 0) {
                proc_mm = 0;  
                perror("not found");
        }   
        else if (!proc_mm)
                non_fatal("found but disabled on command line\n");
        else non_fatal("found\n");
}


I did not find PROC_MM config option in the kernel or any other way to get /proc/mm file.
Is it just old code pending for removal, or am I missing smth... :)

thanks,
Jirka

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
