Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hMNGn-00034R-3T
 for linux-um@lists.infradead.org; Fri, 03 May 2019 01:45:50 +0000
Received: by mail-pf1-x443.google.com with SMTP id t87so1475041pfa.2
 for <linux-um@lists.infradead.org>; Thu, 02 May 2019 18:45:48 -0700 (PDT)
Subject: Re: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com>
 <20190502110220.GD12416@kroah.com>
 <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
 <a49c5088-a821-210c-66de-f422536f5b01@gmail.com>
 <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <1a5f3c44-9fa9-d423-66bf-45255a90c468@gmail.com>
Date: Thu, 2 May 2019 18:45:44 -0700
MIME-Version: 1.0
In-Reply-To: <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, linux-kbuild@vger.kernel.org, "Bird, Timothy  <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt" <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>

On 5/2/19 4:45 PM, Brendan Higgins wrote:
> On Thu, May 2, 2019 at 2:16 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 5/2/19 11:07 AM, Brendan Higgins wrote:
>>> On Thu, May 2, 2019 at 4:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Wed, May 01, 2019 at 04:01:21PM -0700, Brendan Higgins wrote:
>>>>> From: Felix Guo <felixguoxiuping@gmail.com>
>>>>>
>>>>> The ultimate goal is to create minimal isolated test binaries; in the
>>>>> meantime we are using UML to provide the infrastructure to run tests, so
>>>>> define an abstract way to configure and run tests that allow us to
>>>>> change the context in which tests are built without affecting the user.
>>>>> This also makes pretty and dynamic error reporting, and a lot of other
>>>>> nice features easier.
>>>>>
>>>>> kunit_config.py:
>>>>>   - parse .config and Kconfig files.
>>>>>
>>>>> kunit_kernel.py: provides helper functions to:
>>>>>   - configure the kernel using kunitconfig.
>>>>>   - build the kernel with the appropriate configuration.
>>>>>   - provide function to invoke the kernel and stream the output back.
>>>>>
>>>>> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
>>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>>>
>>>> Ah, here's probably my answer to my previous logging format question,
>>>> right?  What's the chance that these wrappers output stuff in a standard
>>>> format that test-framework-tools can already parse?  :)
> 
> To be clear, the test-framework-tools format we are talking about is
> TAP13[1], correct?

I'm not sure what the test community prefers for a format.  I'll let them
jump in and debate that question.


> 
> My understanding is that is what kselftest is being converted to use.
> 
>>>
>>> It should be pretty easy to do. I had some patches that pack up the
>>> results into a serialized format for a presubmit service; it should be
>>> pretty straightforward to take the same logic and just change the
>>> output format.
>>
>> When examining and trying out the previous versions of the patch I found
>> the wrappers useful to provide information about how to control and use
>> the tests, but I had no interest in using the scripts as they do not
>> fit in with my personal environment and workflow.
>>
>> In the previous versions of the patch, these helper scripts are optional,
>> which is good for my use case.  If the helper scripts are required to
> 
> They are still optional.
> 
>> get the data into the proper format then the scripts are not quite so
>> optional, they become the expected environment.  I think the proper
>> format should exist without the helper scripts.
> 
> That's a good point. A couple things,
> 
> First off, supporting TAP13, either in the kernel or the wrapper
> script is not hard, but I don't think that is the real issue that you
> raise.
> 
> If your only concern is that you will always be able to have human
> readable KUnit results printed to the kernel log, that is a guarantee
> I feel comfortable making. Beyond that, I think it is going to take a
> long while before I would feel comfortable guaranteeing anything about
> how will KUnit work, what kind of data it will want to expose, and how
> it will be organized. I think the wrapper script provides a nice
> facade that I can maintain, can mediate between the implementation
> details and the user, and can mediate between the implementation
> details and other pieces of software that might want to consume
> results.
> 
> [1] https://testanything.org/tap-version-13-specification.html

My concern is based on a focus on my little part of the world
(which in _previous_ versions of the patch series was the devicetree
unittest.c tests being converted to use the kunit infrastructure).
If I step back and think of the entire kernel globally I may end
up with a different conclusion - but I'm going to remain myopic
for this email.

I want the test results to be usable by me and my fellow
developers.  I prefer that the test results be easily accessible
(current printk() implementation means that kunit messages are
just as accessible as the current unittest.c printk() output).
If the printk() output needs to be filtered through a script
to generate the actual test results then that is sub-optimal
to me.  It is one more step added to my workflow.  And
potentially with an embedded target a major pain to get a
data file (the kernel log file) transferred from a target
to my development host.

I want a reported test failure to be easy to trace back to the
point in the source where the failure is reported.  With printk()
the search is a simple grep for the failure message.  If the
failure message has been processed by a script, and then the
failure reported to me in an email, then I may have to look
at the script to reverse engineer how the original failure
message was transformed into the message that was reported
to me in the email.  Then I search for the point in the
source where the failure is reported.  So a basic task has
just become more difficult and time consuming.

-Frank

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

