Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMaSs-0001LH-Hc
 for linux-um@lists.infradead.org; Tue, 13 Nov 2018 15:19:00 +0000
Received: by mail-it1-x141.google.com with SMTP id r12-v6so18709950ita.3
 for <linux-um@lists.infradead.org>; Tue, 13 Nov 2018 07:18:43 -0800 (PST)
Subject: Re: [PATCH 4/4] um: Add support for DISCARD in the UBD Driver
References: <20181113115947.19290-1-anton.ivanov@cambridgegreys.com>
 <20181113115947.19290-5-anton.ivanov@cambridgegreys.com>
 <699c4f90-4f77-bf9c-d613-1294fe9c8cdc@kernel.dk>
 <3c6646a7-b16b-56eb-7aa4-a78ff18f8c08@cambridgegreys.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9ddf9a89-cc69-08ba-c204-5ebc45e15db6@kernel.dk>
Date: Tue, 13 Nov 2018 08:18:39 -0700
MIME-Version: 1.0
In-Reply-To: <3c6646a7-b16b-56eb-7aa4-a78ff18f8c08@cambridgegreys.com>
Content-Language: en-US
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: richard@nod.at, hch@lst.de

On 11/13/18 7:04 AM, Anton Ivanov wrote:
> On 13/11/2018 13:40, Jens Axboe wrote:
>> On 11/13/18 4:59 AM, anton.ivanov@cambridgegreys.com wrote:
>>> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
>>> index 2b1aaf7755aa..e817fd4a4c30 100644
>>> --- a/arch/um/drivers/Kconfig
>>> +++ b/arch/um/drivers/Kconfig
>>> @@ -1,4 +1,25 @@
>>>   # SPDX-License-Identifier: GPL-2.0
>>> +menu "UML Block Devices"
>>> +
>>> +config BLK_DEV_UBD
>>> +	bool "UBD Block Device"
>>> +	default y
>>> +	help
>>> +          User Mode Linux virtual block device driver
>>> +
>>> +config BLK_DEV_UBD_SYNC
>>> +	bool "Use Synchronous mode for UBD"
>>> +	default n
>>> +	help
>>> +          Perform all disk operations synchronously (extremely slow).
>>> +
>>> +config BLK_DEV_UBD_DISCARD
>>> +	bool "Enable DISCARD/TRIM support in UBD"
>>> +	default y
>>> +	help
>>> +          Enable discard/trim support. Requires host kernel 3.x or above and
>>> +	  may not be supported on all host filesystems.
>>> +endmenu
>> kconfig entries are horrible ways to manage this. A module parameter
>> would be better. The latter also gets rid of the various ifdefs.
> 
> I completely agree with you. Unfortunately, UBD for a number of reasons 
> cannot be a module at present. It contains "host" side and loading 
> something from the "inside" which breaks the hypervisor boundary is a 
> definitive no go.
> 
> In order to implement the suggestion we need the concept of loadable 
> host side modules and while that is possible the likelihood of someone 
> doing all the work on this one at present is rather low.

Module parameters work for builtin as well, then you just add
ubd.discard=true to the kernel command line.

>>> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
>>> index e78f27f5ce88..4fd4cb68f033 100644
>>> --- a/arch/um/drivers/ubd_kern.c
>>> +++ b/arch/um/drivers/ubd_kern.c
>>> @@ -513,9 +513,13 @@ static void ubd_handler(void)
>>>   		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
>>>   			struct io_thread_req *io_req = (*irq_req_buffer)[count];
>>>   
>>> -			if (!blk_update_request(io_req->req, io_req->error, io_req->length))
>>> -				__blk_mq_end_request(io_req->req, io_req->error);
>>> -
>>> +			if ((io_req->error) || (io_req->buffer == NULL)) {
>>> +				blk_mq_end_request(io_req->req, io_req->error);
>>> +			} else {
>>> +				if (!blk_update_request(io_req->req, io_req->error, io_req->length)) {
>>> +					__blk_mq_end_request(io_req->req, io_req->error);
>>> +				}
>>> +			}
>>>   			kfree(io_req);
>> This looks odd, why is this change necessary? Also a lot of unneeded
>> parentheses.
> 
> Loop and NBD do it that way. I can retest with the original code now 
> that the underlying culprit is known and resubmit if that works.

I missed the __ part, yes it actually looks fine. blk_mq_end_request() will
both end the bio parts and free the request, your latter part does incremental
completes.

>>> @@ -775,6 +779,7 @@ static int ubd_open_dev(struct ubd *ubd_dev)
>>>   	char **back_ptr;
>>>   	int err, create_cow, *create_ptr;
>>>   	int fd;
>>> +	int data;
>>>   
>>>   	ubd_dev->openflags = ubd_dev->boot_openflags;
>>>   	create_cow = 0;
>>> @@ -829,6 +834,23 @@ static int ubd_open_dev(struct ubd *ubd_dev)
>>>   		if(err < 0) goto error;
>>>   		ubd_dev->cow.fd = err;
>>>   	}
>>> +#ifdef CONFIG_BLK_DEV_UBD_DISCARD
>>> +	if (ubd_dev->cow.file != NULL)
>>> +		fd = ubd_dev->cow.fd;
>>> +	else
>>> +		fd = ubd_dev->fd;
>>> +	err = os_pread_file(fd, &data, sizeof(int), 0);
>>> +	if (err == sizeof(int)) {
>>> +		err = os_falloc_punch(fd, 0, sizeof(int));
>>> +		if (err == 0) {
>> It's not clear to me how it's safe to punch a 4-byte hole in the file as
>> a test?
> 
> A sizeof(int) sized hole is always implemented by simply writing zeroes. 
> There is no fs manipulation here.
> 
> The test reads the contents of the file, punches a hoile and writes the 
> content back if the hole was punched successfully so the file is in its 
> orginal state.
> 
> Life would have been much easier if fallocate did not return -EINVAL on 
> a 0 sized request. Unfortunately it does so any test has no choice but 
> to punch a hole for real and fix the damage after that.
> 
> The location is completely safe for most UMLs UBDs. The most common 
> method of building images is to format a device directly with ext2/3/4 - 
> there is no partition table. The first sector in ext2/3/4 if memory 
> serves me right is unused. Other fs - less so. Partition table - totally 
> safe as the boot code portion is unused.
> 
> In any case, the code restores the data to its pre-test state.

It's a bit nasty... You'd probably want to do a full sector though, the
fs isn't going to be issuing a trim for anything that small.

What happens if the system crashes before you successfully write back
the data you zeroed? Doesn't seem like a really safe way to do this.

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

