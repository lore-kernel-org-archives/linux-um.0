Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1R2LRw-0007EQ-1j
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2011 11:10:16 +0000
Received: from mail-qy0-f175.google.com ([209.85.216.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1R2LRv-0004di-29
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2011 11:10:15 +0000
Received: by qyk10 with SMTP id 10so687934qyk.13
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 10 Sep 2011 04:10:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f3c8fff4b732b2681fb1ea20a80d5b8a@hellstrom.st>
References: <f3c8fff4b732b2681fb1ea20a80d5b8a@hellstrom.st>
Date: Sat, 10 Sep 2011 13:10:09 +0200
Message-ID: <CAFLxGvw=qnpxdfzV0_mzDw7HJTDLfpnVStFXHSKzTRqLh_Q6vw@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Errors in schedule / _switch_to
To: =?ISO-8859-1?Q?Oscar_Hellstr=F6m?= <oscar@hellstrom.st>
Cc: user-mode-linux-devel@lists.sourceforge.net

2011/9/9 Oscar Hellstr=F6m <oscar@hellstrom.st>:
>
> Any pointer to what this can be and where I can start looking would be
> appreciated!
>

Does with also happen with a vanilla kernel?
Do you have a full trace? The value of EIP would be helpful.

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Malware Security Report: Protecting Your Business, Customers, and the =

Bottom Line. Protect your business and customers by understanding the =

threat from malware and how it can impact your online business. =

http://www.accelacomm.com/jaw/sfnl/114/51427462/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

