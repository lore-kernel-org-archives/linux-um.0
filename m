Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A18yr-0001im-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 21 Sep 2003 11:30:45 -0700
Received: from web80507.mail.yahoo.com ([66.218.79.77])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A18yp-0003F8-SH
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Sep 2003 11:30:43 -0700
Message-ID: <20030921183013.99560.qmail@web80507.mail.yahoo.com>
From: Terry <td3201@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] mounting filesystems - mount crashes
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 21 Sep 2003 11:30:13 -0700 (PDT)
To: user-mode-linux-devel@lists.sourceforge.net

Hello,

I am trying to create a filesystem and have it mounted
during boot.  The virtual machine is redhat 9.

I created the filesystem on the host os with dd.  I
boot up my vm with ubd3=/uml/new_fs as a kernel
argument.  WHen inside the VM, I create an ext2
filesystem on it.  I am then able to mount it normally
from there.  When I add it to fstab as:
/dev/ubd/3     /usr            ext2    defaults 1 1
It blows chunks.  

It also did this for my home filesystem and I have to
mount that from rc.local and it works fine but I need
/usr before that.  Any ideas?

Thanks.

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
