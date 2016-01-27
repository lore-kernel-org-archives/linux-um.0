Return-Path: <martin.petersen@oracle.com>
Subject: Re: [PATCH 03/22] scsi: Fix dependencies for !HAS_IOMEM and !HAS_DMA archs
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
	<1453760661-1444-4-git-send-email-richard@nod.at>
	<56A74743.6000308@huawei.com> <56A74AF6.90307@nod.at>
	<56A75082.6050104@huawei.com>
Date: Tue, 26 Jan 2016 21:16:28 -0500
In-Reply-To: <56A75082.6050104@huawei.com> (John Garry's message of "Tue, 26
	Jan 2016 10:54:58 +0000")
Message-ID: <yq137tjix6r.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
To: John Garry <john.garry@huawei.com>
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, "James E.J. Bottomley" <JBottomley@odin.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

>>>>> "John" == John Garry <john.garry@huawei.com> writes:

John> We can just add HAS_IOMEM dependency on the scsi fixes branch, ok?

Yes, please submit a patch against 4.5/scsi-fixes.

-- 
Martin K. Petersen	Oracle Linux Engineering

