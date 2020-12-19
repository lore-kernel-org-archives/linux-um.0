Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from hqnvemgate25.nvidia.com ([216.228.121.64])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kqWHz-0005Fw-Oj
 for linux-um@lists.infradead.org; Sat, 19 Dec 2020 07:04:29 +0000
Subject: Re: set_page_dirty vs truncate
References: <20201218160531.GL15600@casper.infradead.org>
 <20201218220316.GO15600@casper.infradead.org>
 <20201219051852.GP15600@casper.infradead.org>
 <7a7c3052-74c7-c63b-5fe3-65d692c1c5d1@nvidia.com>
 <20201219065057.GR15600@casper.infradead.org>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <43f05a8f-25ce-a400-5825-d8fa159ee7f6@nvidia.com>
Date: Fri, 18 Dec 2020 23:04:23 -0800
MIME-Version: 1.0
In-Reply-To: <20201219065057.GR15600@casper.infradead.org>
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
To: Matthew Wilcox <willy@infradead.org>
Cc: Martin Brandenburg <martin@omnibond.com>, linux-cifs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, Miklos Szeredi <miklos@szeredi.hu>, Dave Kleikamp <shaggy@kernel.org>, Richard Weinberger <richard@nod.at>, Dominique Martinet <asmadeus@codewreck.org>, linux-um@lists.infradead.org, linux-nfs@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, Steve French <sfrench@samba.org>, linux-ntfs-dev@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>, devel@lists.orangefs.org, Anna Schumaker <anna.schumaker@netapp.com>, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <anton@tuxera.com>, Mike Marshall <hubcap@omnibond.com>

On 12/18/20 10:50 PM, Matthew Wilcox wrote:
...
>>> Hmmm ... looks like __set_page_dirty_nobuffers() has a similar problem:
>>>
>>> {
>>>           lock_page_memcg(page);
>>>           if (!TestSetPageDirty(page)) {
>>>                   struct address_space *mapping = page_mapping(page);
>>>                   unsigned long flags;
>>>
>>>                   if (!mapping) {
>>>                           unlock_page_memcg(page);
>>>                           return 1;
>>>                   }
>>>
>>>                   xa_lock_irqsave(&mapping->i_pages, flags);
>>>                   BUG_ON(page_mapping(page) != mapping);
>>>
>>> sure, we check that the page wasn't truncated between set_page_dirty()
>>> and the call to TestSetPageDirty(), but we can truncate dirty pages
>>> with no problem.  So between the call to TestSetPageDirty() and
>>> the call to xa_lock_irqsave(), the page can be truncated, and the
>>> BUG_ON should fire.
>>>
>>> I haven't been able to find any examples of this, but maybe it's just a very
>>> narrow race.  Does anyone recognise this signature?  Adding the filesystems
>>> which use __set_page_dirty_nobuffers() directly without extra locking.
>>
>>
>> That sounds like the same *kind* of failure that Jan Kara and I were
>> seeing on live systems[1], that led eventually to the gup-to-pup
>> conversion exercise.
>>
>> That crash happened due to calling set_page_dirty() on pages that had no
>> buffers on them [2]. And that sounds like *exactly* the same thing as
>> calling __set_page_dirty_nobuffers() without extra locking. So I'd
>> expect that it's Just Wrong To Do, for the same reasons as Jan spells
>> out very clearly in [1].
> 
> Interesting.  It's a bit different, *but* Jan's race might be what's
> causing this symptom.  The reason is that the backtrace contains
> set_page_dirty_lock() which holds the page lock.  So there can't be
> a truncation race because truncate holds the page lock when calling
> ->invalidatepage.
> 
> That said, the syzbot reproducer doesn't have any O_DIRECT in it
> either.  So maybe this is some other race?

Jan's race can be also be reproduced *without* O_DIRECT. I first saw
it via a program that just did these steps on a normal ext4 filesystem:

a) pin ext4 file-backed pages, via get_user_pages(). Actually the way
it got here was due to using what *looked* like anonymous RAM to the
program, but was really file-backed RAM, because the admin had it
set up to mount ext4 on /tmp, instead of using tmpfs, to "save RAM",
but I digress. :)

b) wait a while, optionally do some DMA on the pages from a GPU, drink
coffee...

c) call set_pages_dirty()

d) unpin the pages

e) BUG_ON() in page_buffers().


thanks,
-- 
John Hubbard
NVIDIA

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

