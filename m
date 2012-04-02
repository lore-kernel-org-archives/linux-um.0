Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1SElnu-0005Yw-Ub
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2012 18:16:34 +0000
Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SElnr-0006ZC-1d
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2012 18:16:34 +0000
Received: by lagw12 with SMTP id w12so4900966lag.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 02 Apr 2012 11:16:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120402211730.19f6baaf@sf.home>
References: <20120402211730.19f6baaf@sf.home>
Date: Mon, 2 Apr 2012 20:16:24 +0200
Message-ID: <CAFLxGvzcSXsYWKR7Ty0wvmukM6yGUzWob5zCfariJUkw6=GcoQ@mail.gmail.com>
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
Subject: Re: [uml-devel] 3.4.0-rc1 is broken due to asm/system.h restructure
To: Sergei Trofimovich <slyich@gmail.com>
Cc: David Howells <dhowells@redhat.com>, user-mode-linux-devel@lists.sourceforge.net

On Mon, Apr 2, 2012 at 8:17 PM, Sergei Trofimovich <slyich@gmail.com> wrote:
> The asm/system.h patches missed ARCH=um
> which caused build breakage [2].
>
> The commit can be used as an example [2].
> I've failed to produce fix myself. Sorry.

See:

http://comments.gmane.org/gmane.linux.kernel/1274493

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

