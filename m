Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1QXGR4-0000ic-GH
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2011 17:32:54 +0000
Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QXGR3-0000Yw-Jq
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2011 17:32:54 +0000
Received: by vxd7 with SMTP id 7so1966619vxd.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 16 Jun 2011 10:32:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4DFA097E.8030108@panasas.com>
References: <4DFA097E.8030108@panasas.com>
Date: Thu, 16 Jun 2011 19:32:48 +0200
Message-ID: <BANLkTi=p6MpcBxM=7ypm+9SwexV2QKzzsg@mail.gmail.com>
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
Subject: Re: [uml-devel] Is there a git tree with all these patches IN
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: Eric Paris <eparis@redhat.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Jun 16, 2011 at 3:47 PM, Boaz Harrosh <bharrosh@panasas.com> wrote:
> Is there a public tree that has all these patches sent to the mailing list
> the last couple of month?

All patches go first into -mm and then to Linus.
When there is a need for it, I can publish my (rebasing) tree on git.kernel=
.org.

> Is this tree included in linux-next?

No.

> I work with uml every day, but neglect to love it as I should ;-)
>
> Richard. Is your goal to have "make allmodconfig" at least compile-able.
> =A0I've noticed that you supplied patches that are common in the compile =
breakages.

In my queue are a few patches to "fix" allmodconfig and allyesconfig.
These fixes disable some stuff which makes not sense on UML.
E.g. W(L)AN drivers...

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

