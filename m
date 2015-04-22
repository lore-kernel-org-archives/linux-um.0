Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Wed, 22 Apr 2015 22:56:45 +0200
Message-Id: <1429736206-11184-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Kill hppfs
To: user-mode-linux-devel@lists.sourceforge.net
Cc: viro@zeniv.linux.org.uk, hch@infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

hch and Al found that hppfs has some serious issues[0].
As the filesystem as never marked as stable nor in heavy use
we decided to rip it out.
If someone is using it, speak up now. I plan to remove it in the v4.2
merge window.

Now we have FUSE which can be used to implement such a filesystem
in a sane way.

Thanks,
//richard

[0] https://lkml.org/lkml/2015/4/21/402
