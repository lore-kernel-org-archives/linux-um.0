Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuubA-0004rF-TX for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jun 2006 10:10:08 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user6920)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fuub9-00066y-5F
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jun 2006 10:10:08 -0700
References: <87sllyl2np.fsf@hades.wkstn.nix>
	<200606252133.41822.blaisorblade@yahoo.it>
	<87veqnhohe.fsf@hades.wkstn.nix>
	<200606261845.55165.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
Date: Mon, 26 Jun 2006 18:09:58 +0100
In-Reply-To: <200606261845.55165.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's message of "Mon,
	26 Jun 2006 18:45:54 +0200")
Message-ID: <87r71bhmhl.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] problems compiling 2.6.17 against glibc 2.4
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Mon, 26 Jun 2006, blaisorblade@yahoo.it wrote:
> Ok, I missed one important bit of info. Plus, MARC archives when searching for 
> author don't support restricting to one ML. So, here's the link to the 
> discussion within UML-devel. Which is just a pointer to the issue (he surely 
> doesn't explain here the security issues).

Oh, it was on *l-k*. Right.

The security issue is (probably) that attackers can stick stuff into a
jmp_buf if they can successfully execute arbitrary code in some (buggy)
function, and thus can trigger a later longjmp() by the application
which would go somewhere unexpected. glibc fixes this by xoring the
pointers in the jmp_buf with (IIRC) a TLS-stored random cookie (much as
-fstack-protector sticks a TLS-stored random cookie on the stack;
obviously it can't actually modify the on-stack return address, so that
is the next best thing).

A shame Roland wasn't listening in: he made the original changes and
he's a lot more, well, *helpful* than Ulrich... he'll say what
the problem is where Ulrich will just growl at you.

-- 
`NB: Anyone suggesting that we should say "Tibibytes" instead of
 Terabytes there will be hunted down and brutally slain.
 That is all.' --- Matthew Wilcox

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
