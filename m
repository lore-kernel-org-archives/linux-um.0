Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1SEam6-0001tz-Tj
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2012 06:29:59 +0000
Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SEam5-0000Jn-Uv
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2012 06:29:58 +0000
Received: by lagw12 with SMTP id w12so3945724lag.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 01 Apr 2012 23:29:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0uvj49xgsm.ln2@news.researchut.com>
References: <0uvj49xgsm.ln2@news.researchut.com>
Date: Mon, 2 Apr 2012 08:29:51 +0200
Message-ID: <CAFLxGvx2fDWexwA1wmLZ4T0EDaUcaMiROrP-_diQi6bGTNEkyw@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] uml build failure on arch i386
To: Ritesh Raj Sarraf <rrs@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Mar 31, 2012 at 8:44 PM, Ritesh Raj Sarraf <rrs@debian.org> wrote:
> Hello,
>
> I am trying to build uml on kernel 3.2. Following is the build failure I
> get when building on my kvm x86 box.
>
> The kvm box is arch:
> root@debian-x86:~/user-mode-linux (build)# uname -a
> Linux debian-x86 3.0.0-1-686-pae #1 SMP Sat Aug 27 16:41:03 UTC 2011
> i686 GNU/Linux
>
>
> My initial search led me to:
> http://sourceforge.net/mailarchive/message.php?msg_id=27848489
>
> Based on the comment there, I've tried SUBARCH=i386. But that didn't
> help. Any suggestions?

Please share your .config.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

