Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AX3IQ-0004FT-IY
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 10:54:50 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AX3IP-00075R-RO
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 10:54:50 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] skas3 + 2.4.21 oops
References: <20031216163134.GA30608@axis.demon.co.uk> <200312180115.hBI1F5kS007913@ccure.user-mode-linux.org>
In-Reply-To: <200312180115.hBI1F5kS007913@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312181958.43662.blaisorblade_spam@yahoo.it>
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
Date: Thu, 18 Dec 2003 19:58:43 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 02:15, gioved=EC 18 dicembre 2003, Jeff Dike ha scritto:
> ncw1@axis.demon.co.uk said:
> > We are running the skas3 patch (host-skas3.patch from the uml website)
> > on top of a debian 2.4.21 kernel tree with fairsched.  We got these
> > oopses recently.  After the second the server was basically unusable -
> > any attempt to use tools like ps to access the process table just
> > never returned.
>
> This might be incidental - one of the oopsing things might have grabbed t=
he
> task_list semaphore before crapping out.

Check well, Jeff; I remember a mail from you with someone who complained ab=
out=20
ps or ls /proc locking, and you answered that someone locked task_list; I'v=
e=20
read old messages recently, so maybe it's an old one and you don't remember.

In fact, I've found it on the uml-user list. In fact, it happens on the UML=
=20
guest, but since the UML patch bundles the skas one(for nested UML's) I=20
wouldn't be sure these are not connected...

--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
