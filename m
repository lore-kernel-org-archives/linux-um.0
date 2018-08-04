Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: kbuild: ARCH=um archheaders failed
References: <be4f41de-c27a-abac-4b23-369c400e016e@infradead.org>
 <861c26a6-294c-755d-2396-e5d18b9bbcbf@infradead.org>
 <CAK7LNARdoeKCNYV7Kp6YLNsJ4rjrjXRWMsf4op58-JzRYUNVtg@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <29f9908d-06e5-8e88-4433-9bd7935a0d1f@infradead.org>
Date: Sat, 4 Aug 2018 08:47:20 -0700
MIME-Version: 1.0
In-Reply-To: <CAK7LNARdoeKCNYV7Kp6YLNsJ4rjrjXRWMsf4op58-JzRYUNVtg@mail.gmail.com>
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
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>

On 08/03/2018 07:23 PM, Masahiro Yamada wrote:
> 2018-08-04 0:41 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
>> On 08/02/2018 05:13 PM, Randy Dunlap wrote:
>>> Hi Yamada-san,
>>>
>>> I see this every few weeks.  It's not reproducible (it depends
>>> on the moon, Mars, etc.).
>>>
>>> I'm using O=builddir.  The build log is short (below).
>>>
>>> Do you see a makefile problem here?  (nothing to do with mmotm;
>>> I see it more frequently with linux-next since I do many daily
>>> builds with it)
>>
>> BTW, this is just um defconfig with -j4.
>>
>> --
>> ~Randy
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> I will send a patch with commit description later
> after more testing,
> but the following patch should fix the issue.
> 
> 
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index d3975e7..1cec053 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -120,7 +120,7 @@ archheaders:
>         $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
>                     kbuild-file=$(HOST_DIR)/include/uapi/asm/Kbuild \
>                     obj=$(HOST_DIR)/include/generated/uapi/asm
> -       $(Q)$(MAKE) KBUILD_SRC= ARCH=$(HEADER_ARCH) archheaders
> +       $(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) archheaders
> 
> 
>  archprepare: include/generated/user_constants.h
> 
> 
> 

I tested this patch and it works.  :)
but then it's difficult to reproduce the problem.

Thanks!
-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

