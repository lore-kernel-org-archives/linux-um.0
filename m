Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZwM2-0006lH-O2
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Dec 2003 10:06:30 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AZwM2-0000mN-6y
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Dec 2003 10:06:30 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312261905.48277.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] UML patches against vanilla 2.6.0
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
Date: Fri, 26 Dec 2003 19:05:48 +0100
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Go here:

http://web.tiscali.it/no-redirect-tiscali/blaisorblade/index.html

to fetch a bunch of patches against stock 2.6.0 kernel to build UML(no, you 
don't need the -test9 patch on main site: it's included). That page describes 
main changes of it against the latest 2.6 patch.
They are described in the Readme, that you *should* read; the tarball contains 
that Readme, too.

To apply this, you must apply all the patches in order apart from the F-02 
one. If you are a developer, you can check the README and see what you want.

You can then build both i386 with SKAS support and UML from the same tree. The 
SKAS guest kernels should work also on 2.4 host, unless you take the F-02 
patch, too (between the split-out ones).

Now I've collected also some patches from Ingo Molnar and Michael A. Young; 
the only remaining issue with this package is with Fedora (workarounds 
available, see the Readme). Plus all the patches still to port from UML 2.4.

If you are just a user, and you find 00-Combo-1.patch.bz2, fetch and apply it:

bzcat 00-Combo-1.patch.bz2|patch -p1

I've not yet built this combo patch since I've not got one 2.6.0 which is 
truely "vanilla". I hope you'll find it soon.

Bye
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
