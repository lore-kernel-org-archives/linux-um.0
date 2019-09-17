Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iA9Us-00039q-FS
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 09:10:08 +0000
Subject: Re: [RFC v2 2/2] um: implement time-travel=ext
References: <1568671815-I895f9019593bd579566f14e5af9346e3c9b56f28@changeid>
 <1568671815-I0c06fae89d77d5b272dfb4c7ea64641b597b5c7b@changeid>
 <7583ac26d787ddf211473166136836f3472bf31e.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <1dd9e658-a6cd-39dd-09c7-d68ebcd7078c@cambridgegreys.com>
Date: Tue, 17 Sep 2019 10:09:56 +0100
MIME-Version: 1.0
In-Reply-To: <7583ac26d787ddf211473166136836f3472bf31e.camel@sipsolutions.net>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org



On 16/09/2019 23:14, Johannes Berg wrote:
> On Tue, 2019-09-17 at 00:10 +0200, Johannes Berg wrote:
>>
>>   arch/um/drivers/virtio_uml.c          |  59 ++++++-
>>   arch/um/include/linux/time-internal.h |  28 +++
>>   arch/um/include/shared/os.h           |   1 +
>>   arch/um/kernel/skas/syscall.c         |   3 +-
>>   arch/um/kernel/time.c                 | 243 ++++++++++++++++++++++++--
>>   arch/um/os-Linux/file.c               |  31 ++++
>>   include/uapi/linux/um_timetravel.h    | 107 ++++++++++++
>>   7 files changed, 458 insertions(+), 14 deletions(-)
>>   create mode 100644 include/uapi/linux/um_timetravel.h
> 
> FWIW, this does seem nicer than
> 
>>   arch/um/Kconfig                       |  13 ++
>>   arch/um/drivers/virtio_uml.c          | 204 ++++++++++++++++-
>>   arch/um/include/linux/time-internal.h |  14 ++
>>   arch/um/include/shared/os.h           |   6 +
>>   arch/um/kernel/time.c                 | 315 +++++++++++++++++++++++++-
>>   arch/um/os-Linux/file.c               | 116 ++++++++++
>>   include/uapi/linux/virtio_ids.h       |   2 +
>>   include/uapi/linux/virtio_simtime.h   |  99 ++++++++
>>   8 files changed, 755 insertions(+), 14 deletions(-)
>>   create mode 100644 include/uapi/linux/virtio_simtime.h
> 
> (which isn't even the whole story, I neglected one of the patches)
> 
> 
> Also, it seems somewhat faster - my virtio-based one usually ran in a
> bit over 1.5 seconds, this one usually takes around 1.1-1.2 seconds for
> the same test.
> 
> It does still have a bug with interrupt delivery, I get a warning there
> that I need to check out, I doubt it'll affect the code much though.
> 
> johannes
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

Cool.

I hope you do not mind - will repeat my ask. Can we have a series off 
let's say current 5.x with all patches ready for test/review.

Some of your patches have 3-4 versions with a fixed version coming 
nearly immediately thereafter and for some of them I am a bit lost which 
versions should I test/review at present.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

