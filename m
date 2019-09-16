Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9zGN-0000qn-EQ
 for linux-um@lists.infradead.org; Mon, 16 Sep 2019 22:14:28 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>) id 1i9zGM-0000My-65
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 00:14:26 +0200
Message-ID: <7583ac26d787ddf211473166136836f3472bf31e.camel@sipsolutions.net>
Subject: Re: [RFC v2 2/2] um: implement time-travel=ext
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 17 Sep 2019 00:14:25 +0200
In-Reply-To: <1568671815-I0c06fae89d77d5b272dfb4c7ea64641b597b5c7b@changeid>
References: <1568671815-I895f9019593bd579566f14e5af9346e3c9b56f28@changeid>
 <1568671815-I0c06fae89d77d5b272dfb4c7ea64641b597b5c7b@changeid>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

On Tue, 2019-09-17 at 00:10 +0200, Johannes Berg wrote:
> 
>  arch/um/drivers/virtio_uml.c          |  59 ++++++-
>  arch/um/include/linux/time-internal.h |  28 +++
>  arch/um/include/shared/os.h           |   1 +
>  arch/um/kernel/skas/syscall.c         |   3 +-
>  arch/um/kernel/time.c                 | 243 ++++++++++++++++++++++++--
>  arch/um/os-Linux/file.c               |  31 ++++
>  include/uapi/linux/um_timetravel.h    | 107 ++++++++++++
>  7 files changed, 458 insertions(+), 14 deletions(-)
>  create mode 100644 include/uapi/linux/um_timetravel.h

FWIW, this does seem nicer than

>  arch/um/Kconfig                       |  13 ++
>  arch/um/drivers/virtio_uml.c          | 204 ++++++++++++++++-
>  arch/um/include/linux/time-internal.h |  14 ++
>  arch/um/include/shared/os.h           |   6 +
>  arch/um/kernel/time.c                 | 315 +++++++++++++++++++++++++-
>  arch/um/os-Linux/file.c               | 116 ++++++++++
>  include/uapi/linux/virtio_ids.h       |   2 +
>  include/uapi/linux/virtio_simtime.h   |  99 ++++++++
>  8 files changed, 755 insertions(+), 14 deletions(-)
>  create mode 100644 include/uapi/linux/virtio_simtime.h

(which isn't even the whole story, I neglected one of the patches)


Also, it seems somewhat faster - my virtio-based one usually ran in a
bit over 1.5 seconds, this one usually takes around 1.1-1.2 seconds for
the same test.

It does still have a bug with interrupt delivery, I get a warning there
that I need to check out, I doubt it'll affect the code much though.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

