Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AT0ja-0001MI-Rk
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 07 Dec 2003 07:22:10 -0800
Received: from m17.lax.untd.com ([64.136.30.80])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AT0ja-0000Q2-HY
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 07 Dec 2003 07:22:10 -0800
Message-ID: <20031207.071354.-1654081.1.mcmechanjw@juno.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary=--__JNP_000_17ad.6b79.1509
From: James W McMechan <mcmechanjw@juno.com>
Subject: [uml-devel] make clean & distclean are not cleaning up
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
Date: Sat, 6 Dec 2003 20:20:22 -0800
To: user-mode-linux-devel@lists.sourceforge.net


This message is in MIME format.  Since your mail reader does not understand
this format, some or all of this message may not be legible.

----__JNP_000_17ad.6b79.1509
Content-Type: text/plain; charset=us-ascii  
Content-Transfer-Encoding: 7bit

It is looking like make clean & make distclean don't clear some          
      
of the headers :(                                                        
      
I had a config with TT off and then turned it on then I got a            
      
undefined TASK_EXTERN_PID for tt/gdb.c so I did a make clean,            
      
still no luck, make distclean alas did not clear the problem,            
      
so I just generated a new symlink tree to compile in, but I was          
      
startled that distclean did not clear out the configuration.
----__JNP_000_17ad.6b79.1509
Content-Type: text/html; charset=us-ascii  
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1264" name=3DGENERATOR></HEAD>
<BODY bottomMargin=3D0 leftMargin=3D3 topMargin=3D0 rightMargin=3D3>It is =
looking like=20
make clean &amp; make distclean don't clear=20
some&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>of the headers=20
:(&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;=20
<BR>I had a config with TT off and then turned it on then I got=20
a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>undefined TASK_EXTERN_PID for tt/gdb.c so I did a make=20
clean,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>still no luck, make distclean alas did not clear the=20
problem,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>so I just generated a new symlink tree to compile in, but I=20
was&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>startled that distclean did not clear out the configuration.</BODY></=
HTML>

----__JNP_000_17ad.6b79.1509--


________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
