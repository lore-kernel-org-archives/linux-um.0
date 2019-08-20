Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i09Uf-0005kt-FT
 for linux-um@lists.infradead.org; Tue, 20 Aug 2019 19:08:34 +0000
Subject: Re: [PATCH v13 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
References: <20190814055108.214253-1-brendanhiggins@google.com>
 <5b880f49-0213-1a6e-9c9f-153e6ab91eeb@kernel.org>
 <20190820182450.GA38078@google.com>
From: shuah <shuah@kernel.org>
Message-ID: <e8eaf28e-75df-c966-809a-2e3631353cc9@kernel.org>
Date: Tue, 20 Aug 2019 13:08:28 -0600
MIME-Version: 1.0
In-Reply-To: <20190820182450.GA38078@google.com>
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, peterz@infradead.org, amir73il@gmail.com, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, yamada.masahiro@socionext.com, mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, frowand.list@gmail.com, robh@kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, shuah <shuah@kernel.org>, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, jpoimboe@redhat.com, Bjorn Helgaas <bhelgaas@google.com>, kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at, sboyd@kernel.org, gregkh@linuxfoundation.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org, logang@deltatee.com

On 8/20/19 12:24 PM, Brendan Higgins wrote:
> On Tue, Aug 20, 2019 at 11:24:45AM -0600, shuah wrote:
>> On 8/13/19 11:50 PM, Brendan Higgins wrote:
>>> ## TL;DR
>>>
>>> This revision addresses comments from Stephen and Bjorn Helgaas. Most
>>> changes are pretty minor stuff that doesn't affect the API in anyway.
>>> One significant change, however, is that I added support for freeing
>>> kunit_resource managed resources before the test case is finished via
>>> kunit_resource_destroy(). Additionally, Bjorn pointed out that I broke
>>> KUnit on certain configurations (like the default one for x86, whoops).
>>>
>>> Based on Stephen's feedback on the previous change, I think we are
>>> pretty close. I am not expecting any significant changes from here on
>>> out.
>>>
>>
>> Hi Brendan,
>>
>> I found checkpatch errors in one or two patches. Can you fix those and
>> send v14.
> 
> Hi Shuah,
> 
> Are you refering to the following errors?
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> #144: FILE: include/kunit/test.h:456:
> +#define KUNIT_BINARY_CLASS \
> +       kunit_binary_assert, KUNIT_INIT_BINARY_ASSERT_STRUCT
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> #146: FILE: include/kunit/test.h:458:
> +#define KUNIT_BINARY_PTR_CLASS \
> +       kunit_binary_ptr_assert, KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT
> 
> These values should *not* be in parentheses. I am guessing checkpatch is
> getting confused and thinks that these are complex expressions, when
> they are not.
> 
> I ignored the errors since I figured checkpatch was complaining
> erroneously.
> 
> I could refactor the code to remove these macros entirely, but I think
> the code is cleaner with them.
> 

Please do. I am not veru sure what value these macros add.

thanks,
-- Shuah

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

