Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AU9w9-0001kQ-En
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 10 Dec 2003 11:23:53 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AU9w8-0005qr-R0
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 10 Dec 2003 11:23:53 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] fix for: Host panic when UML reads host /dev/shm
References: <20031210.073651.-388765.0.mcmechanjw@juno.com>
In-Reply-To: <20031210.073651.-388765.0.mcmechanjw@juno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312102027.31059.blaisorblade_spam@yahoo.it>
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
Date: Wed, 10 Dec 2003 20:27:30 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: James W McMechan <mcmechanjw@juno.com>

Alle 16:36, mercoled=EC 10 dicembre 2003, James W McMechan ha scritto:
> Ok here are the two patches one each for 2.4.23
> and 2.6.0-test11
> Linus has accepted the test11 patch into bk so
> the next 2.6 kernel should have the fix
> I have also been testing a 2.4.23 patch
> They no longer oopes with any of my test programs
> Since you were having problems here they are
Compliments for the catch! I had been trying uselessly to find the bug insi=
de=20
the shm code(I had found that which was the invalid pointer, but nothing=20
after that)...

Are you going to send that for 2.4.24? That one will be the last 2.4 kernel=
...
In the meantime, I think that people at http://www.hardrock.org/ will be ha=
ppy=20
of it... it's the -uv tree(not very famous, maybe, but even kerneltrap.org =

speaks about it).

By the way: if this is the problem, then why didn't the kernel oops on /pro=
c=20
reads? Isn't it a memory based fs, too?

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
