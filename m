Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiuTp-0002Yw-Rk for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 03:55:37 -0800
Received: from m17.lax.untd.com ([64.136.30.80])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AiuTp-00062k-IN for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 03:55:37 -0800
Subject: Re: [uml-devel] uml-patch-2.6.0
Message-ID: <20040120.034639.-421335.6.mcmechanjw@juno.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary=--__JNP_000_232f.5445.7d23
From: James W McMechan <mcmechanjw@juno.com>
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
Date: Tue, 20 Jan 2004 03:45:48 -0800
To: user-mode-linux-devel@lists.sourceforge.net


This message is in MIME format.  Since your mail reader does not understand
this format, some or all of this message may not be legible.

----__JNP_000_232f.5445.7d23
Content-Type: text/plain; charset=us-ascii  
Content-Transfer-Encoding: 7bit

For a while I had a similar problem where IRQ 14? would
trigger and attempt to add_timer_randomness before the
random driver's _init section had been run so it would go
into one of the infinite segfault loops on a un-initialized
variable, I just added a check on the pointer being
set, and returned if it was not.  This only seems to happen
on faster machines 1G PIII or 1.4G Athlon my 200MHz
Pentium MMXes at home don't show this effect.
I am normally paranoid about un-initialized vars for just
these sort of reasons, it was a pain to track down, but
I had plenty of time on a new years day cross country
flight to hunt for it.

I just fixed it for my use by a simple extra check, not calling it
would of course be better but I did not care where the fast path
was, slow but working is much better than fast and wedged.
I think the base problem is that yet another assumption is being
broken by UML or the random device
or the magic init order is wrong again :(

likely the patch is mangled but here it is.
--- linux-2.6.0/drivers/char/random.c 2003-11-26 12:42:56.000000000 -0800
+++ G-03-2.6.0/drivers/char/random.c 2004-01-01 14:18:52.000000000 -0800
@@ -790,6 +760,8 @@
         __s32                delta, delta2, delta3;
         int                        entropy = 0;

+if (!random_state) return;
+
         /* if over the trickle threshold, use only 1 in 4096 samples */
         if ( random_state->entropy_count > trickle_thresh &&
                (__get_cpu_var(trickle_count)__ & 0xfff))
----__JNP_000_232f.5445.7d23
Content-Type: text/html; charset=us-ascii  
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3Dcontent-type content=3Dtext/html;charset=3Diso-8859-1>
<META content=3D"MSHTML 6.00.2800.1264" name=3DGENERATOR></HEAD>
<BODY bottomMargin=3D0 leftMargin=3D3 topMargin=3D0 rightMargin=3D3>
<DIV>For a while I had a similar problem where IRQ 14? would</DIV>
<DIV>trigger and attempt to add_timer_randomness before the</DIV>
<DIV>random driver's _init section had been run so it would go</DIV>
<DIV>into one of the infinite segfault loops on a un-initialized</DIV>
<DIV>variable, I just added a check on the pointer being</DIV>
<DIV>set, and returned if it was not.&nbsp; This only seems to happen</DIV>
<DIV>on faster machines 1G PIII or 1.4G Athlon my 200MHz</DIV>
<DIV>Pentium MMXes at home don't show this effect.</DIV>
<DIV>I am normally paranoid about un-initialized vars for just</DIV>
<DIV>these sort of reasons, it was a pain to track down, but</DIV>
<DIV>I had plenty of&nbsp;time on a new years day cross country</DIV>
<DIV>flight to hunt for it.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I just fixed it for my use by a simple extra check, not calling it</=
DIV>
<DIV>would of course be better but I did not care where the fast path</DIV>
<DIV>was, slow but working is much better than fast and wedged.</DIV>
<DIV>I think the base problem is that yet another assumption is being</DIV>
<DIV>broken by UML or&nbsp;the random device</DIV>
<DIV>or the magic init order is wrong again :(</DIV>
<DIV>&nbsp;</DIV>
<DIV>likely the patch is mangled but here it is.</DIV>
<DIV>--- linux-2.6.0/drivers/char/random.c 2003-11-26 12:42:56.000000000=20
-0800</DIV>
<DIV>+++ G-03-2.6.0/drivers/char/random.c 2004-01-01 14:18:52.000000000=20
-0800</DIV>
<DIV>@@ -790,6 +760,8 @@</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
__s32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; delta, delta2, delta3;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entropy =3D 0;</DIV>
<DIV>&nbsp;</DIV>
<DIV>+if (!random_state) return;</DIV>
<DIV>+</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if over the =
trickle=20
threshold, use only 1 in 4096 samples */</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=20
random_state-&gt;entropy_count &gt; trickle_thresh &amp;&amp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (__get_cpu_var(trickle_count)__ =
&amp;=20
0xfff))</DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

----__JNP_000_232f.5445.7d23--


________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
