Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXQPL-0003Bd-FN
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 11:35:31 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AXQPK-0006Mv-Rx
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 11:35:31 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] new_mm : /proc/mm copy_segments failed, err = 0
References: <Pine.LNX.4.58.0312171735540.8123@earth> <Pine.LNX.4.58.0312181514140.7622@earth> <slrnbu6j80.6le.lunz@absolut.localnet>
In-Reply-To: <slrnbu6j80.6le.lunz@absolut.localnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200312192038.48325.blaisorblade_spam@yahoo.it>
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
Date: Fri, 19 Dec 2003 20:38:48 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Ingo Molnar <mingo@elte.hu>

Alle 20:09, venerd=EC 19 dicembre 2003, Jason Lunz ha scritto:
> The problem is that on every process fork, I see $Subject appear one or
> more times on the console, and subjectively the uml seems to be running
> a little slowly. Is this normal?

No, it's a little bug from the host patch; to fix it, edit mm/proc_mm.c and=
=20
find this code inside write_proc_mm function:

       /* Not necessary anymore - for compatibility only */
       case MM_COPY_SEGMENTS:
               ret =3D 0;
then replace the line "ret =3D 0; " with "ret =3D count;"
For Ingo: it's a write() call, after all, so it must return the count of=20
"written" bytes... see the line above the switch().
Bye
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
