Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWPc1-0005rL-4p
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 16:32:25 -0800
Received: from tailtiu.davidcoulson.net ([207.166.203.132] helo=mail.mx.davidcoulson.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AWPc0-0007b1-Je
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 16:32:24 -0800
Message-ID: <3FDFA414.9060004@davidcoulson.net>
From: David Coulson <david@davidcoulson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Unresolved symbols with 2.4.23 & 2.4.22-7um:
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
Date: Tue, 16 Dec 2003 19:32:20 -0500
To: user-mode-linux-devel@lists.sourceforge.net

depmod: *** Unresolved symbols in 
/home/david/build/mods/lib/modules/2.4.23-djc3-7um/kernel/drivers/net/pppoe.o
depmod:         copy_from_user_tt
depmod:         copy_to_user_tt
depmod:         copy_to_user_skas
depmod:         copy_from_user_skas

I added these to arch/um/kernel/ksyms.c

David

-- 
David Coulson                                    email: d@vidcoulson.com
Linux Developer /                          web: http://davidcoulson.net/
Network Engineer                                   phone: (216) 533-6967



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
