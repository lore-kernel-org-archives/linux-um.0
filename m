Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXVgR-0002me-89
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 17:13:31 -0800
Received: from mta9.adelphia.net ([68.168.78.199])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXVgQ-0007Ko-Tv
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 17:13:31 -0800
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20031220011323.GW18100@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] 2.4.22-[67] problems
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
Date: Fri, 19 Dec 2003 17:13:23 -0800
To: user-mode-linux-devel@lists.sourceforge.net
Cc: 224431@bugs.debian.org, 224502@bugs.debian.org

There definitely seems to be something awry here, even in skas mode.  I am
getting a lot of ENOSYS errors inside UML:

/usr/lib/apt/methods/http: error while loading shared libraries: libc.so.6: cannot map zero-fill pages: Error 38

dpkg: error processing /var/cache/apt/archives/debhelper_4.0.2_all.deb (--unpack):
 failed to rmdir/unlink `/usr/share/man/man1/dh_compress.1.gz.dpkg-tmp': Function not implemented

basename: write error: Function not implemented

etc.

Downgrading to user-mode-linux 2.4.22-6um-1 still has the problem,
downgrading further to 2.4.22-5um-1 (the old binary) fixes it.  The
following things changed from 2.4.22-5um-1 to 2.4.22-6um-1, most of which
were outside of UML itself:

1. -6um and later were built with a glibc using 2.6 kernel headers
(linux-kernel-headers in Debian unstable).  This also required a patch to
get UML to compile:

@@ -35628,7 +35631,7 @@
 +       */
 +static void disable_lcall(void)
 +{
-+      struct modify_ldt_ldt_s ldt;
++      struct user_desc ldt;
 +      int err;
 +
 +      bzero(&ldt, sizeof(ldt));
@@ -36784,7 +36787,7 @@
 +      nregs = sizeof(dummy->u_debugreg)/sizeof(dummy->u_debugreg[0]);
 +      for(i = 0; i < nregs; i++){
 +              if((i == 4) || (i == 5)) continue;
-+              if(ptrace(PTRACE_POKEUSR, pid, &dummy->u_debugreg[i],
++              if(ptrace(PTRACE_POKEUSER, pid, &dummy->u_debugreg[i],
 +                        regs[i]) < 0)
 +                      printk("write_debugregs - ptrace failed on "
 +                             "register %d, errno = %d\n", errno);
@@ -36799,7 +36802,7 @@
 +      dummy = NULL;
 +      nregs = sizeof(dummy->u_debugreg)/sizeof(dummy->u_debugreg[0]);
 +      for(i = 0; i < nregs; i++){
-+              regs[i] = ptrace(PTRACE_PEEKUSR, pid, 
++              regs[i] = ptrace(PTRACE_PEEKUSER, pid, 
 +                               &dummy->u_debugreg[i], 0);
 +      }
 +}

2. CONFIG_UML_REAL_TIME_CLOCK=y was added to the configuration

3. Various newer versions of the compiler toolchain were used, with the
exception of gcc (the Debian package has been explicitly building using gcc
2.95 for a long time)

4. Update Debian kernel source tree

So at this point, I don't know whether something in the development
environment has broken UML, or if UML has broken itself somehow.  I haven't
tried patching 2.4.22-5um to compile with linux-kernel-headers yet, so I
don't know whether a new binary of that older code would also work.  I don't
know whether I'm dealing with one bug or several.

There are a lot of factors to try to eliminate, so to help with the
investigation, I'd like to know if anyone else s seeing problems similar to
http://bugs.debian.org/{224431,224502}, the ENOSYS errors shown above, or
anything else strange with 2.4.22-6um or -7um, or after updating any
toolchain components.  I'd especially like to hear from Debian unstable
users, especially anyone building from non-Debian kernel sources.

Thanks...

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
