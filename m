Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXjNB-0007WW-Br
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 07:50:33 -0800
Received: from dimitri1.net1.nerim.net ([62.212.102.53] helo=sengena.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.24)
	id 1AXjNA-0007Mo-PZ
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 07:50:33 -0800
Message-ID: <354202003164938-nicospam@sengena.com>
From: "Nicolas Dimitrijevic" <uml-nicospam@sengena.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] skas patch 2.6.0 -A4 mistake
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 20 Dec 2003 16:50:25 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi, I'm new here, with a really poor english, so, i will be short ;)

From the patch of Ingo Molnar 2.6.0-A4, it seem that you have modified the case MM_COPY_SEGMENTS has 'BlaisorBlade' has suggested, but at the wrong place:

you have changed the ret=0 to ret=count in the PTRACE_SWITCH_MM case from file kernel/ptrace.c instead of MM_COPY_SEGMENTS case from mm/proc_mm.c

nicod

--
Nicolas Dimitrijevic - Sengena SARL - http://www.sengena.com
tel: (33)4 91 40 46 50


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
