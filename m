Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hzyZk-0006WU-Ds
 for linux-um@lists.infradead.org; Tue, 20 Aug 2019 07:29:06 +0000
Subject: Re: [PATCH 2/2] um: drivers: Add virtio vhost-user driver
References: <20190731202942.29630-1-johannes@sipsolutions.net>
 <20190731202942.29630-2-johannes@sipsolutions.net>
 <aa0e9645-add5-0169-95d0-e11dc36dcfaa@cambridgegreys.com>
 <57a7df50-0a87-a8a6-7cd7-e4aa2ef35f1d@cambridgegreys.com>
 <3ffcf614-ce0e-949c-b0dd-49551866f7cf@cambridgegreys.com>
 <55F06090E0044C4F985D9B415677B33F4E42700B@HASMSX110.ger.corp.intel.com>
 <fcf30eb6-b26c-f9d8-eb3f-c2475b8a298d@cambridgegreys.com>
 <7296b73881732bb4d4bd7cff2e5ad4f192f6eec7.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <6714a1cc-ff35-38e2-3538-f4f435e79b1b@cambridgegreys.com>
Date: Tue, 20 Aug 2019 08:28:50 +0100
MIME-Version: 1.0
In-Reply-To: <7296b73881732bb4d4bd7cff2e5ad4f192f6eec7.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>, "Geron, ErelX" <erelx.geron@intel.com>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>



On 20/08/2019 08:18, Johannes Berg wrote:
> On Thu, 2019-08-15 at 06:03 +0100, Anton Ivanov wrote:
>>
>> rc = vhost_user_get_config(vu_dev, offset, buf, len)
>>
>> if (unlikely(rc)) {
>> 	printk(KERN_ERR "vu get returned error %i", rc);
>> 	WARN();
>> }
> 
> Just for the record, IMHO that's better written as
> 
> rc = vhost_user_get_config(...);
> WARN(rc, "vu_get_config returned error %d\n", rc);
> 
> since that will embed the message/error code into the warning message.
> 
> johannes
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

Agree.

In either case, the current WARN() and WARN_ON in the patch should be 
revised to ensure that the error code is not lost.

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

