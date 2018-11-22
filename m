Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gPl7P-0008Dq-29
 for linux-um@lists.infradead.org; Thu, 22 Nov 2018 09:17:56 +0000
Subject: Re: [PATCH] um: Remove unnecessary kmap_atomic in uaccess on 64bit
References: <20181116083215.7165-1-anton.ivanov@cambridgegreys.com>
 <CANB_DmtJAp6aye5_mnuCzf5D_hmAES+WEJcvYOUWPsaFXBL9vQ@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <dd9e487e-b984-09fa-9293-c6855219429a@cambridgegreys.com>
Date: Thu, 22 Nov 2018 09:17:13 +0000
MIME-Version: 1.0
In-Reply-To: <CANB_DmtJAp6aye5_mnuCzf5D_hmAES+WEJcvYOUWPsaFXBL9vQ@mail.gmail.com>
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
To: liwei <liwei@anbutu.com>
Cc: richard@nod.at, linux-um@lists.infradead.org


On 11/22/18 2:09 AM, liwei wrote:
> Hi Anton,
>
> On Fri, Nov 16, 2018 at 4:32 PM <anton.ivanov@cambridgegreys.com> wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> On 64 bit architectures it is not necessary to perform highmem
>> kmap_/kunmap for various copy to/from user operations. The mmu
>> emulation on its own is sufficient to provide the correct address
>> offset to execute a memcpy().
>>
>> This results in 3%-7% improvement in various copy_to/from ops.
>>
>> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> ---
>>   arch/um/kernel/skas/uaccess.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
>> index d450797a3a7c..615be3ec98eb 100644
>> --- a/arch/um/kernel/skas/uaccess.c
>> +++ b/arch/um/kernel/skas/uaccess.c
>> @@ -69,20 +69,26 @@ static int do_op_one_page(unsigned long addr, int len, int is_write,
>>                  return -1;
>>
>>          page = pte_page(*pte);
>> +       current->thread.fault_catcher = &buf;
>> +       faulted = UML_SETJMP(&buf);
> I'm wondering why should we move these in front of kmap_atomic(), as
> in a faulted situation
> this will lead to a second kmap_atomic() execution.

Thanks for noting.

I think they are needed only for the case where we do a simple 
page_addr, instead of kmap_atomic because kmap_atomic temporarily turns 
off paging.

So if pte is non-null (as checked by the previous if) there should be no 
point to do a faulted check.

I will double check and re-test all combinations.

> Thanks
>
>> +#ifndef CONFIG_64BIT
>>          addr = (unsigned long) kmap_atomic(page) +
>>                  (addr & ~PAGE_MASK);
>> +#else
>> +       addr = (unsigned long) page_address(page) +
>> +               (addr & ~PAGE_MASK);
>> +#endif
>>
>> -       current->thread.fault_catcher = &buf;
>>
>> -       faulted = UML_SETJMP(&buf);
>>          if (faulted == 0)
>>                  n = (*op)(addr, len, arg);
>>          else
>>                  n = -1;
>>
>>          current->thread.fault_catcher = NULL;
>> -
>> +#ifndef CONFIG_64BIT
>>          kunmap_atomic((void *)addr);
>> +#endif
>>
>>          return n;
>>   }
>> --
>> 2.11.0
>>
>>
>> _______________________________________________
>> linux-um mailing list
>> linux-um@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-um

Brgds,

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

