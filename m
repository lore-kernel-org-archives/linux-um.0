Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAJ1p-0003Bl-Jh for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Mar 2005 18:40:29 -0800
Received: from rwcrmhc13.comcast.net ([204.127.198.39])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAJ1o-0001R7-9H for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Mar 2005 18:40:29 -0800
From: Ryan Anderson <ryan@michonline.com>
Message-ID: <20050313024014.GZ7828@mythryan2.michonline.com>
References: <20050307182828.GS7828@mythryan2.michonline.com>
	<200503091003.02120.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503091003.02120.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH] UML - Restore proper descriptions in make deb-pkg
	target
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
Date: Sat, 12 Mar 2005 21:40:14 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Ryan Anderson <ryan@michonline.com>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>

On Wed, Mar 09, 2005 at 10:03:01AM +0100, Blaisorblade wrote:
> 
> Yes, it must go in... only the Description is a bit problematic, since you'll 
> get with the below:
> Description: Linux kernel, version linux-2.6.11
> 
> Description: Linux kernel, version user-mode-linux-2.6.11

Good point.

This pulls the description from the Debian user-mode-linux package, and
puts $version back in the appropriate places for both descriptions.

Incremental on top of the previous patch.

Signed-off-by: Ryan Anderson <ryan@michonline.com>

Index: local-quilt/scripts/package/builddeb
===================================================================
--- local-quilt.orig/scripts/package/builddeb	2005-03-12 20:36:24.000000000 -0500
+++ local-quilt/scripts/package/builddeb	2005-03-12 20:40:50.000000000 -0500
@@ -73,6 +73,29 @@
 EOF
 
 # Generate a control file
+if [ "$ARCH" == "um" ]; then
+
+cat <<EOF > debian/control
+Source: linux
+Section: base
+Priority: optional
+Maintainer: $name
+Standards-Version: 3.6.1
+
+Package: $packagename
+Architecture: any
+Description: User Mode Linux kernel, version $version
+ User-mode Linux is a port of the Linux kernel to its own system call
+ interface.  It provides a kind of virtual machine, which runs Linux
+ as a user process under another Linux kernel.  This is useful for
+ kernel development, sandboxes, jails, experimentation, and
+ many other things.
+ .
+ This package contains the Linux kernel, modules and corresponding other
+ files version $version
+EOF
+
+else
 cat <<EOF > debian/control
 Source: linux
 Section: base
@@ -82,10 +105,11 @@
 
 Package: $packagename
 Architecture: any
-Description: Linux kernel, version $packagename
+Description: Linux kernel, version $version
  This package contains the Linux kernel, modules and corresponding other
- files version $packagename
+ files version $version
 EOF
+fi
 
 # Fix some ownership and permissions
 chown -R root:root "$tmpdir"

-- 

Ryan Anderson
  sometimes Pug Majere


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
