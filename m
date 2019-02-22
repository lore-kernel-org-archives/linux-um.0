Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxHog-00013U-Ux
 for linux-um@lists.infradead.org; Fri, 22 Feb 2019 20:53:08 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MKmt0m038231
 for <linux-um@lists.infradead.org>; Fri, 22 Feb 2019 15:53:02 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qtqu8j5tp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-um@lists.infradead.org>; Fri, 22 Feb 2019 15:53:01 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-um@lists.infradead.org> from <bauerman@linux.ibm.com>;
 Fri, 22 Feb 2019 20:53:00 -0000
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <a6ae907e-391b-993e-6011-6f40c761b339@gmail.com>
 <CAFd5g44AmF6eN-HKwHOqPiGZHNc2K_wAmWR3PkV0OX-=YNUKDw@mail.gmail.com>
 <4dff3b1a-7ded-7218-5325-3c397cc3c73e@gmail.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit,
 the Linux kernel unit testing framework
In-reply-to: <4dff3b1a-7ded-7218-5325-3c397cc3c73e@gmail.com>
Date: Fri, 22 Feb 2019 17:52:37 -0300
MIME-Version: 1.0
Message-Id: <871s3zeeay.fsf@morokweng.localdomain>
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
To: Frank Rowand <frowand.list@gmail.com>
Cc: brakmo@fb.com, Petr Mladek <pmladek@suse.com>, Amir Goldstein <amir73il@gmail.com>, Brendan Higgins <brendanhiggins@google.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Richard Weinberger <richard@nod.at>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, "Bird, Timothy" <Tim.Bird@sony.com>, dan.carpenter@oracle.com, devicetree <devicetree@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, Joe Perches <joe@perches.com>, Kevin Hilman <khilman@baylibre.com>


Frank Rowand <frowand.list@gmail.com> writes:

> On 2/19/19 10:34 PM, Brendan Higgins wrote:
>> On Mon, Feb 18, 2019 at 12:02 PM Frank Rowand <frowand.list@gmail.com> wrote:
>> <snip>
>>> I have not read through the patches in any detail.  I have read some of
>>> the code to try to understand the patches to the devicetree unit tests.
>>> So that may limit how valid my comments below are.
>>
>> No problem.
>>
>>>
>>> I found the code difficult to read in places where it should have been
>>> much simpler to read.  Structuring the code in a pseudo object oriented
>>> style meant that everywhere in a code path that I encountered a dynamic
>>> function call, I had to go find where that dynamic function call was
>>> initialized (and being the cautious person that I am, verify that
>>> no where else was the value of that dynamic function call).  With
>>> primitive vi and tags, that search would have instead just been a
>>> simple key press (or at worst a few keys) if hard coded function
>>> calls were done instead of dynamic function calls.  In the code paths
>>> that I looked at, I did not see any case of a dynamic function being
>>> anything other than the value it was originally initialized as.
>>> There may be such cases, I did not read the entire patch set.  There
>>> may also be cases envisioned in the architects mind of how this
>>> flexibility may be of future value.  Dunno.
>>
>> Yeah, a lot of it is intended to make architecture specific
>> implementations and some other future work easier. Some of it is also
>> for testing purposes. Admittedly some is for neither reason, but given
>> the heavy usage elsewhere, I figured there was no harm since it was
>> all private internal usage anyway.
>>
>
> Increasing the cost for me (and all the other potential code readers)
> to read the code is harm.

Dynamic function calls aren't necessary for arch-specific
implementations either. See for example arch_kexec_image_load() in
kernel/kexec_file.c, which uses a weak symbol that is overriden by
arch-specific code. Not everybody likes weak symbols, so another
alternative (which admitedly not everybody likes either) is to use a
macro with the name of the arch-specific function, as used by
arch_kexec_post_alloc_pages() in <linux/kexec.h> for instance.

--
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

