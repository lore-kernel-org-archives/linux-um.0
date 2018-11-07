Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gKU2G-0001yL-KT
 for linux-um@lists.infradead.org; Wed, 07 Nov 2018 20:02:45 +0000
Subject: Re: [RFC v2 01/14] kunit: test: add KUnit test runner core
References: <20181023235750.103146-1-brendanhiggins@google.com>
 <20181023235750.103146-2-brendanhiggins@google.com>
 <017b111f-d960-c1ef-46ae-eb0eb639fe5b@kernel.org>
 <CAFd5g45KNNGPVh4EBm8vKGdVhqajZZA0TU=CFbceJziYufb0Ug@mail.gmail.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <0149d343-937c-1a99-10ff-d2bcb546e49b@kernel.org>
Date: Wed, 7 Nov 2018 13:02:29 -0700
MIME-Version: 1.0
In-Reply-To: <CAFd5g45KNNGPVh4EBm8vKGdVhqajZZA0TU=CFbceJziYufb0Ug@mail.gmail.com>
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
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Rob Herring <robh@kernel.org>, linux-nvdimm@lists.01.org, richard@nod.at, kieran.bingham@ideasonboard.com, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mcgrof@kernel.org, Daniel Vetter <daniel@ffwll.ch>, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On 11/06/2018 06:28 PM, Brendan Higgins wrote:
> On Fri, Nov 2, 2018 at 11:44 AM Shuah Khan <shuah@kernel.org> wrote:
>>
>> On 10/23/2018 05:57 PM, Brendan Higgins wrote:
> <snip>
>>> + * Example:
>>> + *
>>> + * .. code-block:: c
>>> + *
>>> + *   void add_test_basic(struct test *test)
>>> + *   {
>>> + *           TEST_EXPECT_EQ(test, 1, add(1, 0));
>>> + *           TEST_EXPECT_EQ(test, 2, add(1, 1));
>>> + *           TEST_EXPECT_EQ(test, 0, add(-1, 1));
>>> + *           TEST_EXPECT_EQ(test, INT_MAX, add(0, INT_MAX));
>>> + *           TEST_EXPECT_EQ(test, -1, add(INT_MAX, INT_MIN));
>>> + *   }
>>> + *
>>> + *   static struct test_case example_test_cases[] = {
>>> + *           TEST_CASE(add_test_basic),
>>> + *           {},
>>> + *   };
>>> + *
>>> + */
>>> +struct test_case {
>>> +     void (*run_case)(struct test *test);
>>> +     const char name[256];
>>> +
>>> +     /* private: internal use only. */
>>> +     bool success;
>>> +};
>>> +
>>
>> Introducing a prefix kunit_* might be a good idea for the API.
>> This comment applies to the rest of patches as well.
> 
> What about kunit_* instead of test_* and kmock_* instead of mock_*?
> Does that seem reasonable?
> 

kunit_* would work well.

thanks,
-- Shuah

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

