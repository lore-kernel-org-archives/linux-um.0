Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1XroK5-0006SN-3C
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Nov 2014 13:32:29 +0000
Received: from mout.gmx.net ([212.227.17.20])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XroJz-0001wR-97
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Nov 2014 13:32:29 +0000
Message-ID: <546F3EDD.1000007@gmx.de>
Date: Fri, 21 Nov 2014 14:32:13 +0100
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <546CCE10.4010007@gmx.de>
	<CAFLxGvzYBRM3gos1OwkPfihCc_GPUuPs=Quu42rBd6NnrfFKEQ@mail.gmail.com>
In-Reply-To: <CAFLxGvzYBRM3gos1OwkPfihCc_GPUuPs=Quu42rBd6NnrfFKEQ@mail.gmail.com>
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
Subject: Re: [uml-devel] starting an UML image sometimes failed,
 next (identical) attempt works
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On 11/19/2014 10:13 PM, Richard Weinberger wrote:
>> console [mc-1] enabled
>> > Failed to initialize ubd device 0 :Couldn't determine size of device's file
> This is ubd_file_size(). Can you find out where exactly it is failing?
> Just add a few printk()s into it.

Did it:

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index e8ab93c..22390f9 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -508,19 +508,25 @@ static inline int ubd_file_size(struct ubd *ubd_dev, __u64 *size_out)
        int sector_size;
        int bitmap_offset;

+printk(KERN_INFO "ubd_file_size 0");
        if (ubd_dev->file && ubd_dev->cow.file) {
                file = ubd_dev->cow.file;
+printk(KERN_INFO "ubd_file_size 1");

                goto out;
        }

        fd = os_open_file(ubd_dev->file, of_read(OPENFLAGS()), 0);
+printk(KERN_INFO "ubd_file_size 2");
        if (fd < 0)
                return fd;
+printk(KERN_INFO "ubd_file_size 3");

        err = read_cow_header(file_reader, &fd, &version, &backing_file, \
                &mtime, &size, &sector_size, &align, &bitmap_offset);
        os_close_file(fd);
+printk(KERN_INFO "ubd_file_size 4, err=%i", err);

        if(err == -EINVAL)
                file = ubd_dev->file;




but no result so far (did the issue knows that I do observe him ???). I might test if this happens at the first time the UML image file is mounted using a loop device (after reboot of the host).

-- 
Toralf
pgp key: 0076 E94E


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

