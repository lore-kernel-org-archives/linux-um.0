Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DR7D3-0000ey-Of for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 04:29:33 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user84699)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DR7D2-0002b1-0d for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 04:29:33 -0700
Subject: Re: [uml-devel] Question about UML gdb
References: <002901c54b08$223494a0$90b3c68a@SHZ.ST.COM>
	<11346.213.161.231.212.1114638611.squirrel@213.161.231.212>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <11346.213.161.231.212.1114638611.squirrel@213.161.231.212>
	(stian@nixia.no's
	message of "Wed, 27 Apr 2005 23:50:11 +0200 (CEST)")
Message-ID: <87sm1bm965.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Thu, 28 Apr 2005 12:29:22 +0100
To: stian@nixia.no
Cc: Alex LIU <alex.liu@st.com>, UML-dev <user-mode-linux-devel@lists.sourceforge.net>

On Wed, 27 Apr 2005, stian@nixia.no moaned:
> For most applications, the mention address-space is mapped to
> linux-gate.so, which to my understanding is a part of sysenter/tls
> implementation in glibc.

It is the vsyscall implementation; it's exported by the kernel,
not by glibc.

-- 
This is like system("/usr/funky/bin/perl -e 'exec sleep 1'");
   --- Peter da Silva


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
