Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYM1y-0005fr-Kp
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 22 Dec 2003 01:07:14 -0800
Received: from mta9.adelphia.net ([68.168.78.199])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYM1y-0007Vm-At
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 22 Dec 2003 01:07:14 -0800
Received: from mizar.alcor.net ([68.64.159.24]) by mta9.adelphia.net
          (InterMail vM.5.01.06.05 201-253-122-130-105-20030824) with SMTP
          id <20031222090708.BUDZ11838.mta9.adelphia.net@mizar.alcor.net>
          for <user-mode-linux-devel@lists.sourceforge.net>;
          Mon, 22 Dec 2003 04:07:08 -0500
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] skas patch 2.6.0 -A4 mistake
Message-ID: <20031222090707.GC9354@alcor.net>
References: <354202003164938-nicospam@sengena.com> <20031220235615.GA1710@elte.hu> <20031222021055.28b90296.dbharris@eelf.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222021055.28b90296.dbharris@eelf.ddts.net>
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
Date: Mon, 22 Dec 2003 01:07:07 -0800
To: user-mode-linux-devel@lists.sourceforge.net

On Mon, Dec 22, 2003 at 02:10:55AM -0500, David B Harris wrote:

> fsck.ext3: error while loading shared libraries: /lib/libcom_err.so.2: cannot read file data: Error 38

Errno 38 is ENOSYS.  See #224431/#224502.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
