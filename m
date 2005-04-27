Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQuQH-0002C9-4t for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Apr 2005 14:50:21 -0700
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DQuQE-0001dv-E6 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Apr 2005 14:50:21 -0700
Message-ID: <11346.213.161.231.212.1114638611.squirrel@213.161.231.212>
In-Reply-To: <002901c54b08$223494a0$90b3c68a@SHZ.ST.COM>
References: <002901c54b08$223494a0$90b3c68a@SHZ.ST.COM>
Subject: Re: [uml-devel] Question about UML gdb
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Date: Wed, 27 Apr 2005 23:50:11 +0200 (CEST)
To: Alex LIU <alex.liu@st.com>
Cc: UML-dev <user-mode-linux-devel@lists.sourceforge.net>

> I have 2 questions about UML gdb:
>
> 1.how to get the address of current process UML gdb?
> It seems "esp & 0xffffe000" is not the correct address.

For most applications, the mention address-space is mapped to
linux-gate.so, which to my understanding is a part of sysenter/tls
implementation in glibc. Either make gdb breakpoint (since processes doing
any system calls appear with this setup, or disable tls libraries. Atleast
that works for my setup).
To disable tls:
mv /lib/tls /lib/tls-old
and later to re-enable
mv /lib/tls-old /lib/tls

Hopes this gives any help.

Stian


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
