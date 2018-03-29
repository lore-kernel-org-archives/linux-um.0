Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <richard@nod.at>) id 1f1dzQ-0005vR-Hk
 for user-mode-linux-devel@lists.sourceforge.net;
 Thu, 29 Mar 2018 20:17:40 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f1dzN-002jS0-Jh for user-mode-linux-devel@lists.sourceforge.net;
 Thu, 29 Mar 2018 20:17:40 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 29 Mar 2018 22:17:22 +0200
Message-ID: <56398706.2t5zza2KEm@blindfold>
In-Reply-To: <20180305104142.27608-1-anton.ivanov@cambridgegreys.com>
References: <20180305104142.27608-1-anton.ivanov@cambridgegreys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] Migrate vector timers to new timer API
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: anton.ivanov@cambridgegreys.com
Cc: user-mode-linux-devel@lists.sourceforge.net

Am Montag, 5. M=E4rz 2018, 11:41:42 CEST schrieb anton.ivanov@cambridgegrey=
s.com:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> =

> The patches for the UML vector drivers were in-flight when
> the timer changes happened and were not covered by them.
> =

> This change migrates vector_kern.c to use the new timer API.
> =

> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Applied.

Thanks,
//richard

---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

