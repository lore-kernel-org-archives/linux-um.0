Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mI4lw-00FozD-F5
 for linux-um@lists.infradead.org; Mon, 23 Aug 2021 07:53:36 +0000
Subject: Re: [PATCH, RFC] um: remove set_fs
References: <20210709133836.3821559-1-hch@lst.de>
 <b7b4f02385c2b103d66eadb1dfcff607a28a82b2.camel@sipsolutions.net>
 <20210823070426.GA22184@lst.de>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <f4b1097d-9730-063c-c93c-10d6966c9520@cambridgegreys.com>
Date: Mon, 23 Aug 2021 08:14:10 +0100
MIME-Version: 1.0
In-Reply-To: <20210823070426.GA22184@lst.de>
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
To: Christoph Hellwig <hch@lst.de>, Johannes Berg <johannes@sipsolutions.net>, richard@nod.at
Cc: linux-um@lists.infradead.org

On 23/08/2021 08:04, Christoph Hellwig wrote:
> Richard, Anton - any comments?
> 
> On Fri, Jul 09, 2021 at 04:47:34PM +0200, Johannes Berg wrote:
>> On Fri, 2021-07-09 at 15:38 +0200, Christoph Hellwig wrote:
>>> Remove address space overrides using set_fs() for user mode Linux.
>>>
>>> Compile tested only.
>>
>> Seems to survive my normal (wireless related) tests :)
>>
>> But I don't really understand what any of it does, so ...
>>
>> In particular, why no pagefaults for kernel addresses?
>>
>> johannes
> ---end quoted text---
> 

I will have a look at it today. Sorry, snowed under OVS/OVN.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

