Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CL4dy-0004X6-MO for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 12:00:06 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CL4dv-000265-UG
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 12:00:06 -0700
Received: from hirsch.in-berlin.de (localhost [127.0.0.1])
	by hirsch.in-berlin.de (8.12.11/8.12.11/Debian-3) with ESMTP id
	i9MJ01aF021660 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 22 Oct 2004 21:00:01 +0200
Received: (from uucp@localhost)
	by hirsch.in-berlin.de (8.12.11/8.12.11/Debian-3) with UUCP id
	i9MIj19m020111 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 20:45:01 +0200
Received: from bytesex.org (localhost [127.0.0.1])
	by bytesex.org (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP id
	i9MIfQIF009173 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 22 Oct 2004 20:41:26 +0200
Received: (from kraxel@localhost)
	by bytesex.org (8.12.10/8.12.10/Submit) id i9MIfQEO009172
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 20:41:26 +0200
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20041022184126.GA9104@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patches] ptrace fix, x11 fb update, minor stuff.
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
Date: Fri, 22 Oct 2004 20:41:26 +0200
To: uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

Just uploaded a updated batch of uml patches to
http://www.suse.de/~kraxel/uml/patches/2.6.9/

Changes from -rc2 patchset:

 * Dropped lots of patches because they are merged mainline now.
   Nice work guys!
 * uml-ptrace: new, fixes the ptrace issue (skas-hangs-on-exit).
 * uml-x11-fb: updated, should be fully functional now, including
   mmap support.
 * other patches: some rediffs, no major stuff.

X11 doesn't run yet, the X-Server wants IOPL access for some obscure
reason, it shouldn't need that when running on top of a framebuffer
device.  Anyone has an idea on that?

  Gerd

-- 
return -ENOSIG;


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
